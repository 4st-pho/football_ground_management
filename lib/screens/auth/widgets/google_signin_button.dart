import 'package:flutter/material.dart';
import 'package:football_ground_management/constant/app_string.dart';
import 'package:football_ground_management/constant/app_text_style.dart';
import 'package:football_ground_management/constant/base/app_icon.dart';
import 'package:football_ground_management/services/auth_service.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style:
          OutlinedButton.styleFrom(side: const BorderSide(color: Colors.blue)),
      onPressed: () => AuthService.signInWithGoogle(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Image(image: AssetImage(AppIcon.google), height: 30),
            SizedBox(width: 10),
            Text(
              AppString.signInWithGoogle,
              style: AppTextStyle.blue17PXBold,
            )
          ],
        ),
      ),
    );
  }
}
