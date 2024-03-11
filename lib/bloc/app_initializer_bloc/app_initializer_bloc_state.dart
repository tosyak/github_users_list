part of 'app_initializer_bloc_bloc.dart';

sealed class AppState extends Equatable {
  const AppState();

  @override
  List<Object> get props => [];
}

class AppInitializerStateInitial extends AppState {}

class AppInitializerStateInitialized extends AppState {}
