import 'dart:async';

import 'package:football_ground_management/bloc/base_bloc.dart';

class LoadBloc extends BaseBloc {
  final _loadController = StreamController<bool>();
  Stream<bool> get loadStream => _loadController.stream;
  void setLoadState(bool loadState) {
    _loadController.sink.add(loadState);
  }

  @override
  void dispose() {
    _loadController.close();
  }
}
