import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:football_ground_management/bloc/stadium_detail_bloc.dart';
import 'package:football_ground_management/constant/app_text_style.dart';
import 'package:football_ground_management/constant/route_manager.dart';
import 'package:football_ground_management/di.dart';
import 'package:football_ground_management/model/bill.dart';
import 'package:intl/intl.dart';

class StadiumDetail extends StatefulWidget {
  final String stadiumId;
  const StadiumDetail({super.key, required this.stadiumId});

  @override
  State<StadiumDetail> createState() => _StadiumDetailState();
}

class _StadiumDetailState extends State<StadiumDetail> {
  final stadiumDetailBloc = getIt.get<StadiumDetailBloc>();

  @override
  void initState() {
    super.initState();
    stadiumDetailBloc.listenBillOfStadium(widget.stadiumId);
  }

  @override
  void dispose() {
    stadiumDetailBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Bill>>(
        stream: stadiumDetailBloc.allBillStream,
        initialData: const [],
        builder: (context, snapshot) {
          stadiumDetailBloc.updateCalendar(snapshot.data ?? [], context);
          return DayView(
            showVerticalLine: true,
            timeLineBuilder: (date) => Text(
              '  ${DateFormat('H').format(date)} h',
              style: AppTextStyle.black12PX,
            ),
            timeLineWidth: 55,
            showLiveTimeLineInAllDays: true,
            minDay: DateTime.now(),
            maxDay: DateTime.now().add(const Duration(days: 10)),
            initialDay: DateTime.now(),
            heightPerMinute: 1,
            eventArranger: const SideEventArranger(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .pushNamed(Routes.rentStadium, arguments: widget.stadiumId),
        child: const Icon(Icons.add),
      ),
    );
  }
}
