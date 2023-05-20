import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:football_ground_management/bloc/main_bloc.dart';
import 'package:football_ground_management/constant/app_snack_bar.dart';
import 'package:football_ground_management/di.dart';
import 'package:football_ground_management/screens/auth/login_page.dart';
import 'package:football_ground_management/screens/home/home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final mainBloc = getIt.get<MainBloc>();
  @override
  void initState() {
    mainBloc.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppSnackBar.mainContext = context;
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        final user = snapshot.data;
        if (user != null) return const HomePage();
        return const LoginPage();
      },
    );
  }
}
