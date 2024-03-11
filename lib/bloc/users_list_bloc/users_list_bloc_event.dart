part of 'users_list_bloc_bloc.dart';

sealed class UsersListEvent extends Equatable {
  const UsersListEvent();

  @override
  List<Object> get props => [];
}

class GetUsersEvent extends UsersListEvent {}
