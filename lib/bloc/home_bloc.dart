import 'package:football_ground_management/bloc/base_bloc.dart';
import 'package:football_ground_management/di.dart';
import 'package:football_ground_management/model/stadium.dart';
import 'package:football_ground_management/services/stadium_firestore_service.dart';

class HomeBloc extends BaseBloc {
  final stadiumService = getIt<StadiumFirestoreService>();
  Future<List<Stadium>> fetchAllStadium() {
    return stadiumService.fetchAllStadium();
  }

  @override
  void dispose() {}
}
