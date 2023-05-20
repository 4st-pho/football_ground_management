import 'package:flutter/material.dart';
import 'package:football_ground_management/bloc/load_bloc.dart';
import 'package:football_ground_management/bloc/rent_stadium_bloc.dart';
import 'package:football_ground_management/constant/app_snack_bar.dart';
import 'package:football_ground_management/constant/app_text_style.dart';
import 'package:football_ground_management/constant/route_manager.dart';
import 'package:football_ground_management/di.dart';
import 'package:football_ground_management/screens/widgets/common/dart_button.dart';
import 'package:intl/intl.dart';
import 'package:time_picker_widget/time_picker_widget.dart';

import 'package:football_ground_management/constant/app_string.dart';
import 'package:football_ground_management/screens/widgets/common/commom_text_form_field.dart';

class RentStadium extends StatefulWidget {
  final String stadiumId;

  const RentStadium({
    Key? key,
    required this.stadiumId,
  }) : super(key: key);

  @override
  State<RentStadium> createState() => _RentStadiumState();
}

class _RentStadiumState extends State<RentStadium> {
  final rentStadiumBloc = getIt.get<RentStadiumBloc>();
  final loadBloc = getIt.get<LoadBloc>();
  final _formKey = GlobalKey<FormState>();
  final orderTime = DateTime.now();
  late final TextEditingController _startDayController;
  late final TextEditingController _startTimeController;
  late final TextEditingController _endTimeController;

  void showDayPicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 10)),
    ).then((time) {
      if (time != null) {
        _startDayController.text = DateFormat('dd-MM-yyyy').format(time);
        rentStadiumBloc.convertTimeFromSelectDate(time);
      }
    });
  }

  void showHourPicker(BuildContext context) {
    showCustomTimePicker(
      onFailValidation: (_) {},
      context: context,
      initialTime: const TimeOfDay(hour: 6, minute: 0),
      selectableTimePredicate: (time) =>
          ((time!.hour > 5 && time.hour < 11) ||
              (time.hour > 12 && time.hour < 22)) &&
          time.minute % 60 == 0,
    ).then((time) {
      if (time != null) {
        _convertStartTimeToText(time);
        rentStadiumBloc.convertTimeFromSelectHour(time.hour);
      }
    });
  }

  void _convertStartTimeToText(TimeOfDay time) {
    _startTimeController.text = '${time.hour}:${time.minute}';
    _endTimeController.text = '${time.hour + 1}:${time.minute}';
  }

  Future<void> validateStadiumState() async {
    if (_formKey.currentState!.validate()) {
      try {
        loadBloc.setLoadState(true);
        final isStadiumEmpty =
            await rentStadiumBloc.checkBillIsExist(checkOrderCount: true);
        if (isStadiumEmpty) {
          throw AppString.rentByAnotherPerson;
        }
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushNamed(Routes.phoneVetify);
      } catch (e) {
        AppSnackBar.showTopSnackBarError(e.toString());
      } finally {
        loadBloc.setLoadState(false);
      }
    }
  }

  @override
  void initState() {
    _startDayController = TextEditingController();
    _startTimeController = TextEditingController();
    _endTimeController = TextEditingController();
    rentStadiumBloc.setStadiumId(widget.stadiumId);
    super.initState();
  }

  @override
  void dispose() {
    _startDayController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    loadBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Form(
        key: _formKey,
        child: Column(
          children: [_buildPickTime(), _buildSubmitButton()],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
      ),
      title: const Text(AppString.rentStadium),
    );
  }

  Widget _buildSubmitButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          StreamBuilder<bool>(
            stream: loadBloc.loadStream,
            initialData: false,
            builder: (context, snapshot) {
              final loadState = snapshot.data ?? false;
              return DarkButton(
                onPressed: loadState ? null : () => validateStadiumState(),
                text: AppString.rentStadium,
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildPickTime() {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(AppString.pickTime, style: AppTextStyle.blue20),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 16),
            child: CommonTextFormField(
              controller: _startDayController,
              ontap: () => showDayPicker(),
              lable: AppString.dayOfReciveStadium,
            ),
          ),
          _buildStartAndEndTimeRentStadium(),
        ],
      ),
    );
  }

  Widget _buildStartAndEndTimeRentStadium() {
    return Row(
      children: [
        Expanded(
          child: CommonTextFormField(
            controller: _startTimeController,
            lable: AppString.timeOfReciveStadium,
            ontap: () {
              showHourPicker(context);
            },
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: CommonTextFormField(
            controller: _endTimeController,
            lable: AppString.timeOfRentStadium,
          ),
        ),
      ],
    );
  }
}
