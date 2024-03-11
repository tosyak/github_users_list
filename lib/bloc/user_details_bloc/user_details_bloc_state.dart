part of 'user_details_bloc_bloc.dart';

sealed class UserDetailsEvent extends Equatable {
  const UserDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetUserDetailsEvent extends UserDetailsEvent {
  final String username;

  const GetUserDetailsEvent(this.username);

  @override
  List<Object> get props => [username];
}
