import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../../global_components/background.dart';
import '../../home/views/home_view.dart';
import '../bloc/splash_bloc.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SplashBloc(context: context)..add(const SplashLoadEvent()),
      child: const SplashBody(),
    );
  }
}

class SplashBody extends StatelessWidget {
  const SplashBody({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SplashBloc, SplashState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status == SplashStatus.initial) {
              Future.delayed(const Duration(seconds: 3)).then((value) {
                Navigator.of(context).pushReplacement(HomePage.route());
              });
            }
          },
        ),
      ],
      child: BlocBuilder<SplashBloc, SplashState>(
        builder: (context, state) {
          return Background(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: Lottie.asset('assets/splash_animation.json'),
              ),
            ),
          );
        },
      ),
    );
  }
}
