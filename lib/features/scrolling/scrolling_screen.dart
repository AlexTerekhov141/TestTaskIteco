import 'package:flutter/material.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/products/products.dart';

@RoutePage()
class ScrollingScreen extends StatefulWidget{
  const ScrollingScreen({super.key});

  @override
  State<ScrollingScreen> createState() => _ScrollingScreenState();

}
class _ScrollingScreenState extends State<ScrollingScreen>{
  late final ScrollController _scrollController;
  bool _loadMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final ProductsState state = context.read<ProductsBloc>().state;
    if (state.isLoading) return;

    final double maxScroll = _scrollController.position.maxScrollExtent;
    final double currentScroll = _scrollController.position.pixels;

    if (currentScroll >= maxScroll * 0.7 && !_loadMore) {
      _loadMore = true;
      context.read<ProductsBloc>().add(FetchProducts());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scroll'),
      ),
      body: BlocListener<ProductsBloc, ProductsState>
        (listener:(BuildContext context, ProductsState state){
        if (!state.isLoading) {
          _loadMore = false;
        }
      },
      child: BlocBuilder<ProductsBloc, ProductsState>(
          builder: (BuildContext context, ProductsState state){
            if (state.isLoading && state.products.isEmpty){
              return const Center(child: CircularProgressIndicator(),);
            }
            if (state.error != null && state.products.isEmpty){
              return Center(
                  child: Text(state.error!)
              );
            }
            return ListView.builder(
                controller: _scrollController,
                itemCount: state.products.length + (state.isLoading ? 1 : 0),
                itemBuilder: (BuildContext context, int index){
                  if (index >= state.products.length) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return Container(
                    height: 50,
                    color: Colors.blue,
                    child: Center(child: Text(state.products[index].title),),
                  );
                }
            );
          }
      ),
      )
    );
  }

}