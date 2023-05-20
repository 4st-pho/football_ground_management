import 'package:football_ground_management/bloc/home_bloc.dart';
import 'package:football_ground_management/bloc/main_bloc.dart';
import 'package:football_ground_management/bloc/rent_stadium_bloc.dart';
import 'package:football_ground_management/bloc/stadium_detail_bloc.dart';
import 'package:football_ground_management/bloc/load_bloc.dart';
import 'package:football_ground_management/services/bill_firestore_service.dart';
import 'package:football_ground_management/services/bill_firestore_service_imp.dart';
import 'package:football_ground_management/services/shared_preference_service.dart';
import 'package:football_ground_management/services/shared_preference_service_imp.dart';
import 'package:football_ground_management/services/stadium_firestore_service.dart';
import 'package:football_ground_management/services/stadium_firestore_service_imp.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future inject() async {
  getIt.registerFactory<HomeBloc>(() => HomeBloc());
  getIt.registerFactory<LoadBloc>(() => LoadBloc());
  getIt.registerFactory<StadiumDetailBloc>(() => StadiumDetailBloc());
  getIt.registerFactory<RentStadiumBloc>(() => RentStadiumBloc());

  getIt
      .registerSingleton<StadiumFirestoreService>(StadiumFirestoreServiceImp());

  getIt
      .registerSingleton<SharedPreferenceService>(SharedPreferenceServiceImp());

  getIt.registerSingleton<BillFirestoreService>(BillFirestoreServiceImp());
  getIt.registerSingleton<MainBloc>(MainBloc());
}
