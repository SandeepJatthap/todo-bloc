part of 'splash_bloc.dart';

enum SplashStatus { initial }

final class SplashState extends Equatable {
  const SplashState({
    this.status = SplashStatus.initial,
  });

  final SplashStatus status;

  SplashState copyWith({
    SplashStatus Function()? status,
  }) {
    return SplashState(
      status: status != null ? status() : this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}
