import 'package:flutter/material.dart';
import 'package:football_ground_management/constant/app_text_style.dart';

class DarkButton extends StatelessWidget {
  const DarkButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 52),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        backgroundColor: Colors.black87,
      ),
      onPressed: onPressed,
      child: Text(text, style: AppTextStyle.white18PXW900),
    );
  }
}
