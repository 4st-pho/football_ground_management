import 'package:flutter/material.dart';
import 'package:football_ground_management/constant/app_image.dart';
import 'package:football_ground_management/constant/app_text_style.dart';
import 'package:football_ground_management/model/stadium.dart';
import 'package:football_ground_management/screens/home/widgets/vertical_parallax.dart';

class StadiumItem extends StatelessWidget {
  final Stadium stadium;
  const StadiumItem({
    super.key,
    required this.stadium,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 15,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            width: double.infinity,
            height: 150,
            child: VerticalParallax(
              scrollable: Scrollable.of(context),
              child: Image(
                image: (stadium.image.isEmpty
                    ? const AssetImage(AppImage.stadium)
                    : NetworkImage(stadium.image)) as ImageProvider,
              ),
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.2),
                    Colors.black.withOpacity(0.7),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.6, 1],
                ),
              ),
            ),
          ),
          Positioned(
            left: 60,
            bottom: 40,
            child: Text(
              'Tên sân: ${stadium.name}',
              style: AppTextStyle.white20Bold,
            ),
          ),
          Positioned(
            left: 60,
            bottom: 10,
            child: Text(
              'Loại sân: ${stadium.type}',
              style: AppTextStyle.white16,
            ),
          ),
        ],
      ),
    );
  }
}
