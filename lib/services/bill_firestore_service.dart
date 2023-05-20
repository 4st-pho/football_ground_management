import 'package:football_ground_management/model/bill.dart';

abstract class BillFirestoreService {
  Stream<List<Bill>> listenBillFromNowOnwards(String stadiumId);
  Future<void> createBill(String stadiumId, Bill bill);
  Future<bool> checkBillIsExist(String stadiumId, DateTime time);
}
