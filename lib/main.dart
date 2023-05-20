import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:football_ground_management/constant/route_manager.dart';
import 'package:football_ground_management/di.dart';
import 'package:football_ground_management/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await inject();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CalendarControllerProvider(
      controller: EventController(),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: MaterialApp(
          theme: ThemeData(
            useMaterial3: true,
            // primaryColor: Colors.blue,
            colorSchemeSeed: Colors.blue,
            fontFamily: 'Comfortaa',
          ),
          onGenerateRoute: RouteGenerator.getRoute,
          initialRoute: Routes.mainRoute,
        ),
      ),
    );
  }
}
