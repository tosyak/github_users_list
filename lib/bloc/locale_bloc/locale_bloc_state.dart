part of 'locale_bloc_bloc.dart';

sealed class LocaleBlocState extends Equatable {
  const LocaleBlocState();

  @override
  List<Object?> get props => [];
}

class LocaleBlocInitialState extends LocaleBlocState {}

class LocaleBlocSwitchedState extends LocaleBlocState {
  final Locale localeCode;
  const LocaleBlocSwitchedState(this.localeCode);

  @override
  List<Object?> get props => [localeCode];
}
