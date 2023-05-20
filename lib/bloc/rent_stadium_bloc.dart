import 'package:football_ground_management/bloc/base_bloc.dart';
import 'package:football_ground_management/bloc/main_bloc.dart';
import 'package:football_ground_management/constant/app_string.dart';
import 'package:football_ground_management/di.dart';
import 'package:football_ground_management/model/bill.dart';
import 'package:football_ground_management/services/auth_service.dart';
import 'package:football_ground_management/services/bill_firestore_service.dart';

class RentStadiumBloc extends BaseBloc {
  final mainBloc = getIt.get<MainBloc>();
  static var orderTime = DateTime.now();
  static var stadiumId = '';
  final _billService = getIt.get<BillFirestoreService>();

  convertTimeFromSelectDate(DateTime time) {
    orderTime = DateTime(time.year, time.month, time.day, orderTime.hour);
  }

  convertTimeFromSelectHour(int hour) {
    orderTime = DateTime(orderTime.year, orderTime.month, orderTime.day, hour);
  }

  setStadiumId(String id) {
    stadiumId = id;
  }

  Future<void> rentStadium() async {
    try {
      final isExist = await checkBillIsExist();
      if (isExist) {
        throw 'Sân đã được được đặt trước bởi người khác';
      }
      _billService.createBill(
        stadiumId,
        Bill(
          id: '',
          emailOrPhoneNumber: AuthService.emailOrPhoneNumber,
          startTimePlay: orderTime,
        ),
      );
      mainBloc.increaseOrderCount();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> checkBillIsExist({bool checkOrderCount = false}) async {
    if (checkOrderCount) {
      final orderCount = await mainBloc.getOrderCount();
      if (orderCount >= 2) throw AppString.outOfOrder;
    }
    var time = DateTime.now();
    time = DateTime(time.year, time.month, time.day, time.hour + 1);
    if (orderTime.isBefore(time)) throw 'Ngày giờ đặt sân không hợp lệ';
    return _billService.checkBillIsExist(stadiumId, orderTime);
  }

  @override
  void dispose() {}
}
