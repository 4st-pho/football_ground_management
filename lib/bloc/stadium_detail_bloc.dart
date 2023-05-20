import 'dart:async';

import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:football_ground_management/bloc/base_bloc.dart';
import 'package:football_ground_management/constant/app_text_style.dart';
import 'package:football_ground_management/di.dart';
import 'package:football_ground_management/model/bill.dart';
import 'package:football_ground_management/services/bill_firestore_service.dart';

class StadiumDetailBloc extends BaseBloc {
  final _billService = getIt<BillFirestoreService>();
  final _allBillController = StreamController<List<Bill>>();
  StreamSubscription<List<Bill>>? _billListener;
  Stream<List<Bill>> get allBillStream => _allBillController.stream;

  void listenBillOfStadium(String stadiumId) {
    _billListener =
        _billService.listenBillFromNowOnwards(stadiumId).listen((data) {
      _allBillController.sink.add(data);
    });
  }

  void updateCalendar(
    List<Bill> allBill,
    BuildContext context,
  ) {
    CalendarControllerProvider.of(context).controller.removeWhere((_) => true);

    final events = allBill.map((bill) {
      return CalendarEventData(
        title: 'Đã được đặt',
        titleStyle: AppTextStyle.white14PXLH10,
        description: bill.emailOrPhoneNumber,
        descriptionStyle: AppTextStyle.white14PXLH10,
        color: Colors.blueAccent,
        date: bill.startTimePlay,
        endDate: bill.startTimePlay,
        startTime: bill.startTimePlay,
        endTime: bill.startTimePlay.add(const Duration(hours: 1)),
      );
    }).toList();
    CalendarControllerProvider.of(context).controller.addAll(events);
  }

  @override
  void dispose() {
    _allBillController.close();
    _billListener?.cancel();
  }
}
