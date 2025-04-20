import 'package:flutter/material.dart';
import 'package:my_book_store/src/core/ui/styles/app_colors.dart';

class AppStarRating extends StatefulWidget {
  const AppStarRating({
    super.key,
    required this.initialRating,
    required this.onRatingChanged,
  });

  final int initialRating;
  final ValueChanged<int> onRatingChanged;

  @override
  State<AppStarRating> createState() => _AppStarRatingState();
}

class _AppStarRatingState extends State<AppStarRating> {
  late int _currentRating;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.initialRating;
  }

  void _onStarTapped(int index) {
    setState(() {
      _currentRating = index;
    });
    widget.onRatingChanged(_currentRating);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return IconButton(
          iconSize: 22,
          onPressed: () => _onStarTapped(index + 1),
          icon: Icon(
            index < _currentRating ? Icons.star : Icons.star_border,
            color: context.colors.grayScale.header,
          ),
        );
      }),
    );
  }
}
