import 'package:flutter/material.dart';

class CustomBottomAppBar extends StatelessWidget {
  final int currentIndex;
  final List<Widget> items;
  final Function(int) onTap;
  final Color backgroundColor;

  const CustomBottomAppBar({
    required this.currentIndex,
    required this.items,
    required this.onTap,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: backgroundColor,
      child: Row(
        children: List.generate(items.length, (index) {
          final isSelected = index == currentIndex;
          return Expanded(
            child: TextButton(
              onPressed: () => onTap(index),
              child: items[index],
              style: ButtonStyle(
                // Customize button style as needed
                overlayColor: MaterialStateProperty.all(
                    Colors.transparent), // Disable ripple effect
              ),
            ),
          );
        }),
      ),
    );
  }
}
