part of 'user_details_bloc_bloc.dart';

sealed class UserDetailsState extends Equatable {
  const UserDetailsState();

  @override
  List<Object> get props => [];
}

class UserDetailsInitial extends UserDetailsState {}

class GithubUserDetailsLoading extends UserDetailsState {}

class UserDetailsLoaded extends UserDetailsState {
  final UserDetails user;

  const UserDetailsLoaded(this.user);

  @override
  List<Object> get props => [user];
}

class UserDetailsError extends UserDetailsState {
  final String message;

  const UserDetailsError(this.message);

  @override
  List<Object> get props => [message];
}
