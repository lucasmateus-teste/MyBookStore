import 'package:flutter/material.dart';
import 'package:my_book_store/src/core/ui/styles/app_colors.dart';
import 'package:my_book_store/src/core/ui/styles/text_style.dart';

class AppProfileImage extends StatelessWidget {
  const AppProfileImage({super.key, this.name, this.size = const Size(56, 56)});

  final String? name;
  final photo = null;
  final Size size;

  String _getInitials(String? name) {
    if (name == null || name.isEmpty) return '';

    final parts = name.split(' ');
    if (parts.length > 1) {
      return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    }
    return name[0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: context.colors.primary.df,
      ),
      child: ClipOval(
        child:
            photo != null
                ? Image.network(photo, fit: BoxFit.cover)
                : Center(
                  child: Text(
                    _getInitials(name),
                    style: context.textStyles.link.small.copyWith(
                      color: context.colors.grayScale.bg,
                    ),
                  ),
                ),
      ),
    );
  }
}
