part of 'locale_bloc_bloc.dart';

sealed class LocaleBlocEvent extends Equatable {
  const LocaleBlocEvent();

  @override
  List<Object?> get props => [];
}

class LocaleBlocInitialEvent extends LocaleBlocEvent {}

class LocaleBlocSwitchEvent extends LocaleBlocEvent {
  final Locale locale;
  const LocaleBlocSwitchEvent(this.locale);

  @override
  List<Object?> get props => [locale];
}
