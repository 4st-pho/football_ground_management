import 'package:football_ground_management/model/stadium.dart';

abstract class StadiumFirestoreService {
  Future<List<Stadium>> fetchAllStadium();
}
