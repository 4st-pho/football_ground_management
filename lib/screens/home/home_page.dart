import 'package:calendar_view/calendar_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:football_ground_management/bloc/home_bloc.dart';
import 'package:football_ground_management/constant/app_animation.dart';
import 'package:football_ground_management/constant/app_string.dart';
import 'package:football_ground_management/constant/route_manager.dart';
import 'package:football_ground_management/di.dart';
import 'package:football_ground_management/model/stadium.dart';
import 'package:football_ground_management/screens/home/widgets/stadium_item.dart';
import 'package:football_ground_management/screens/home/widgets/symbols_overlay.dart';
import 'package:football_ground_management/screens/widgets/common/loading_widget.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeBloc = getIt.get<HomeBloc>();
  @override
  Widget build(BuildContext context) {
    return CalendarControllerProvider(
      controller: EventController(),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: FutureBuilder<List<Stadium>>(
          future: homeBloc.fetchAllStadium(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(AppString.errorOccur),
                ),
              );
            }
            if (snapshot.hasData) {
              final stadiums = snapshot.data ?? [];
              return ListView.builder(
                padding: const EdgeInsets.only(bottom: 60),
                itemCount: stadiums.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) return _buildHeader();
                  final stadium = stadiums[index - 1];
                  return _buildStadiumItem(stadium, index - 1);
                },
              );
            }
            return const LoadingWidget();
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: LottieBuilder.asset(AppAnimation.welcome, height: 60),
    );
  }

  Widget _buildStadiumItem(Stadium stadium, int index) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () => Navigator.of(context)
          .pushNamed(Routes.stadiumDetail, arguments: stadium.id),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: StadiumItem(stadium: stadium),
          ),
          if (index.isOdd)
            const SymbolsOverlay(
              type: SymbolsOverlayType.rectangleAndCross,
            )
          else
            const SymbolsOverlay(
              type: SymbolsOverlayType.circleAndTriangle,
            ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(AppString.allStadium),
      actions: [
        IconButton(
          onPressed: () => FirebaseAuth.instance.signOut(),
          icon: const Icon(Icons.logout_outlined),
        )
      ],
    );
  }
}
