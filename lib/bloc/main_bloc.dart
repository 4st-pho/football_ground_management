import 'package:football_ground_management/bloc/base_bloc.dart';
import 'package:football_ground_management/di.dart';
import 'package:football_ground_management/services/shared_preference_service.dart';

class MainBloc extends BaseBloc {
  final sharedPreferenceService = getIt.get<SharedPreferenceService>();

  @override
  void init() {
    sharedPreferenceService.resetOrderPerday();
    super.init();
  }

  Future<void> increaseOrderCount() =>
      sharedPreferenceService.increaseOrderCount();
  Future<int> getOrderCount() => sharedPreferenceService.getOrderCount();

  @override
  void dispose() {}
}
