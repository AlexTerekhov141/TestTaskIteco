import 'dart:async';

import 'package:flutter/material.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itecotesttask/features/scrolling/widgets/product_card.dart';

import '../../bloc/products/products.dart';

@RoutePage()
class ScrollingScreen extends StatefulWidget{
  const ScrollingScreen({super.key});

  @override
  State<ScrollingScreen> createState() => _ScrollingScreenState();

}
class _ScrollingScreenState extends State<ScrollingScreen> {
  late final ScrollController _scrollController;
  bool _loadMore = false;
  Timer? _retryTimer;
  bool _hasRetriedAfterError = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final ProductsState state = context
        .read<ProductsBloc>()
        .state;
    if (state.isLoading || state.isLoadingMore) return;

    final double threshold = 600;

    if (_scrollController.position.extentAfter < threshold && !_loadMore) {
      _loadMore = true;
      _hasRetriedAfterError = false;
      context.read<ProductsBloc>().add(FetchMoreProducts());
    }
  }

  void _retryFetch() {
    _retryTimer?.cancel();

    _retryTimer = Timer(const Duration(milliseconds: 1), () {
      if (!mounted) return;

      final ProductsState state = context.read<ProductsBloc>().state;

      if (!state.isLoadingMore && state.error != null && !_hasRetriedAfterError) {
        _hasRetriedAfterError = true;
        _loadMore = true;
        context.read<ProductsBloc>().add(FetchMoreProducts());
      }
    });
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Scroll', style: theme.textTheme.headlineMedium,),
        ),
        body: BlocListener<ProductsBloc, ProductsState>
          (listener: (BuildContext context, ProductsState state) {
          if (!state.isLoadingMore) {
            _loadMore = false;
          }
          if (state.error != null) {
            _retryFetch();
          } else {
            _retryTimer?.cancel();
            _hasRetriedAfterError = false;
          }
        },
          child: BlocBuilder<ProductsBloc, ProductsState>(
              builder: (BuildContext context, ProductsState state) {
                if (state.isLoading && state.products.isEmpty) {
                  return const Center(child: CircularProgressIndicator(),);
                }
                if (state.error != null && state.products.isEmpty) {
                  return Center(
                      child: Text(state.error!)
                  );
                }
                return ListView.builder(
                    controller: _scrollController,
                    itemCount: state.products.length +
                        (state.isLoadingMore ? 1 : 0),
                    itemBuilder: (BuildContext context, int index) {
                      if (index >= state.products.length) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      return ProductCard(product: state.products[index]);
                    }
                );
              }
          ),
        )
    );
  }

}