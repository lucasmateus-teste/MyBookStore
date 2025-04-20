import 'package:flutter/material.dart';

class AppBockStoreIcon extends StatelessWidget {
  const AppBockStoreIcon({super.key, this.size, this.withLabel = true});

  final Size? size;
  final bool withLabel;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      withLabel
          ? 'assets/images/logo_roxa.png'
          : 'assets/images/simbolo_roxa.png',

      width: size?.width,
      height: size?.height,
      fit: BoxFit.fill,
    );
  }
}
