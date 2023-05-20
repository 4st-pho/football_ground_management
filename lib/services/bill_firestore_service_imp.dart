import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:football_ground_management/model/bill.dart';
import 'package:football_ground_management/services/bill_firestore_service.dart';

class BillFirestoreServiceImp extends BillFirestoreService {
  final billColection = FirebaseFirestore.instance.collection('C_BILL');

  @override
  Stream<List<Bill>> listenBillFromNowOnwards(String stadiumId) {
    final now = DateTime.now();
    final snapshots = billColection
        .doc(stadiumId)
        .collection('SC_BILL')
        .where(
          'startTimePlay',
          isGreaterThanOrEqualTo:
              DateTime(now.year, now.month, now.day, 0, 0, 0),
        )
        .snapshots();
    return snapshots.map(
      (data) => data.docs.map((e) => Bill.fromJson(e.data(), e.id)).toList(),
    );
  }

  @override
  Future<void> createBill(String stadiumId, Bill bill) async {
    await billColection.doc(stadiumId).collection('SC_BILL').add(bill.toJson());
  }

  @override
  Future<bool> checkBillIsExist(String stadiumId, DateTime time) async {
    final data = await billColection
        .doc(stadiumId)
        .collection('SC_BILL')
        .where('startTimePlay', isEqualTo: Timestamp.fromDate(time))
        .get();
    return data.docs.isNotEmpty;
  }
}
