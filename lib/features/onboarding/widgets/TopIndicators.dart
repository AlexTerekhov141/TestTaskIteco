import 'package:flutter/material.dart';

import '../../../core/constants.dart';

class TopIndicators extends StatelessWidget{
  const TopIndicators({
    required this.itemCount,
    required this.currentIndex,
  });

  final int itemCount;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(itemCount, (int index){
        final bool isActive = index == currentIndex;
        return AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            margin: const EdgeInsets.all(4),
            height: 4,
            width: isActive ? 24 : 10,
            decoration: BoxDecoration(
              color: isActive ? Green.c500 :  Base.c50,
              borderRadius:  BorderRadius.circular(999)
            ),
        );
      }
      )
    );
  }

}