import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:football_ground_management/model/stadium.dart';
import 'package:football_ground_management/services/stadium_firestore_service.dart';

class StadiumFirestoreServiceImp extends StadiumFirestoreService {
  final stadiumDoc = FirebaseFirestore.instance.collection('C_STADIUM');
  @override
  Future<List<Stadium>> fetchAllStadium() async {
    final stadiums = await stadiumDoc.orderBy('displayOrder').get();
    return stadiums.docs.map((e) => Stadium.fromJson(e.data(), e.id)).toList();
  }
}
