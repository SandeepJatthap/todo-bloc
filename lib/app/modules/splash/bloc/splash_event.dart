part of 'splash_bloc.dart';

sealed class SplashEvent extends Equatable {
  const SplashEvent();

  @override
  List<Object> get props => [];
}

final class SplashLoadEvent extends SplashEvent {
  const SplashLoadEvent();
}
