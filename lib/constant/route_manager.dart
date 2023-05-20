import 'package:flutter/material.dart';
import 'package:football_ground_management/constant/app_string.dart';
import 'package:football_ground_management/screens/auth/login_page.dart';
import 'package:football_ground_management/screens/auth/phone_vetify.dart';
import 'package:football_ground_management/screens/auth/verify_code.dart';
import 'package:football_ground_management/screens/main/main_page.dart';
import 'package:football_ground_management/screens/rent_stadium/rent_stadium.dart';
import 'package:football_ground_management/screens/stadium_detail/stadium_detail.dart';

class Routes {
  static const String mainRoute = '/';
  static const String loginRoute = '/loginRoute';
  static const String stadiumDetail = '/stadiumDetail';
  static const String rentStadium = '/rentStadium';
  static const String phoneVetify = '/phoneVetify';
  static const String vetifyCode = '/vetifyCode';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.mainRoute:
        return MaterialPageRoute(
          builder: (context) => const MainPage(),
        );
      case Routes.loginRoute:
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
        );
      case Routes.stadiumDetail:
        final id = routeSettings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => StadiumDetail(stadiumId: id),
        );
      case Routes.rentStadium:
        final id = routeSettings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => RentStadium(stadiumId: id),
        );
      case Routes.phoneVetify:
        return MaterialPageRoute(
          builder: (context) => const PhoneVetify(),
        );
      case Routes.vetifyCode:
        final verificationId = routeSettings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => VerifyCode(verificationId: verificationId),
        );

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(AppString.noRouteFound),
        ),
        body: const Center(child: Text(AppString.noRouteFound)),
      ),
    );
  }
}
