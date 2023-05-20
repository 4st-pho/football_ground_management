import 'package:flutter/material.dart';
import 'package:football_ground_management/constant/app_animation.dart';
import 'package:football_ground_management/constant/app_string.dart';
import 'package:football_ground_management/screens/auth/widgets/google_signin_button.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [_buildLogo(context), _buildLoginButton()],
      ),
    );
  }

  Widget _buildLoginButton() {
    return const Padding(
      padding: EdgeInsets.all(10),
      child: GoogleSignInButton(),
    );
  }

  Widget _buildLogo(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(AppAnimation.login),
            const SizedBox(height: 100),
            Text(
              AppString.welcome,
              style: Theme.of(context).textTheme.headlineSmall,
            )
          ],
        ),
      ),
    );
  }
}
