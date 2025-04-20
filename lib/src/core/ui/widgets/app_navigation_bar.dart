import 'package:flutter/material.dart';
import 'package:my_book_store/src/core/ui/styles/app_colors.dart';

class AppNavigationBar extends StatefulWidget {
  const AppNavigationBar({
    super.key,
    required this.items,
    this.onTap,
    this.selectedIndex = 0,
  });

  final int selectedIndex;
  final ValueChanged<int>? onTap;
  final List<BottomNavigationBarItem> items;

  @override
  State<AppNavigationBar> createState() => _AppNavigationBarState();
}

class _AppNavigationBarState extends State<AppNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,
      decoration: BoxDecoration(
        color: context.colors.grayScale.transparent90,
        border: Border(
          top: BorderSide(color: context.colors.grayScale.line, width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children:
            widget.items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isSelected = index == widget.selectedIndex;

              return GestureDetector(
                onTap: () {
                  widget.onTap?.call(index);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.only(top: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconTheme(
                        data: IconThemeData(
                          size: isSelected ? 30 : 24,
                          color:
                              isSelected
                                  ? context.colors.grayScale.header
                                  : context.colors.grayScale.placeholder,
                        ),
                        child: item.icon,
                      ),
                      const SizedBox(height: 4),
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 300),
                        style: TextStyle(
                          fontSize: isSelected ? 14 : 0,
                          color:
                              isSelected
                                  ? context.colors.grayScale.header
                                  : Colors.transparent,
                          fontWeight: FontWeight.w600,
                        ),
                        child: Text(item.label ?? ''),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}
