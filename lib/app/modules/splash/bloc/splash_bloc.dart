import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../home/views/home_view.dart';

part 'splash_event.dart';

part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc({required this.context}) : super(const SplashState()) {
    on<SplashLoadEvent>(_addDelay);
  }

  BuildContext context;

  Future<void> _addDelay(
    SplashLoadEvent event,
    Emitter<SplashState> emit,
  ) async {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      Navigator.of(context).pushReplacement(HomePage.route());
    });
  }
}
