import 'package:flutter/material.dart';
import 'package:football_ground_management/constant/app_image.dart';
import 'package:football_ground_management/screens/home/widgets/scroll_offset.dart';

enum SymbolsOverlayType {
  circleAndTriangle(asset: AppImage.messsi, alignment: Alignment.topLeft),
  rectangleAndCross(asset: AppImage.ronaldo, alignment: Alignment.topRight);

  final String asset;
  final Alignment alignment;

  const SymbolsOverlayType({
    required this.asset,
    required this.alignment,
  });
}

class SymbolsOverlay extends StatelessWidget {
  const SymbolsOverlay({
    super.key,
    required this.type,
  });

  final SymbolsOverlayType type;

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);

    final side = data.size.width * 0.5;
    final offset = side * 0.2;
    final factor = data.size.height * 0.15;

    return IgnorePointer(
      child: Align(
        alignment: type.alignment,
        child: ScrollOffset(
          scrollable: Scrollable.of(context),
          factor: factor,
          initialOffset: Offset(
            type.alignment.x < Alignment.center.x ? -offset : offset,
            0,
          ),
          child: SizedBox(
            height: side,
            width: side,
            child: Image.asset(type.asset, fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}
