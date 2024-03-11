part of 'splash_bloc_bloc.dart';

sealed class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object?> get props => [];
}

class SplashInitial extends SplashState {}

class SplashNetworkConnected extends SplashState {}

class SplashNetworkNotConnected extends SplashState {}
