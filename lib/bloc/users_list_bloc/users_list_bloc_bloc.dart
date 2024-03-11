import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';

import 'package:github_test_app/data/models/user_model.dart';
import 'package:github_test_app/data/repository/api_repository.dart';

part 'users_list_bloc_event.dart';
part 'users_list_bloc_state.dart';

// This enum represents the different states the UsersListBloc can be in
enum UserStatus { loading, success, error }

class UsersListBloc extends Bloc<UsersListEvent, UsersListState> {
  final UsersListRepository usersListRepository;
  // Constructor injects the UsersListRepository dependency
  UsersListBloc(this.usersListRepository) : super(const UsersListState()) {
    on<UsersListEvent>((event, emit) async {
      if (event is GetUsersEvent) {
        // Check if we've already reached the maximum users before proceeding
        if (state.hasReachedMax) return;
        try {
          if (state.status == UserStatus.loading) {
            final usersList = await usersListRepository.getUsersListResponse();
            return usersList.isEmpty
                ? emit(state.copyWith(
                    status: UserStatus.success,
                    hasReachedMax: true)) // Update state to loading
                : emit(state.copyWith(
                    status: UserStatus.success,
                    users: usersList,
                    hasReachedMax: false));
          } else {
            final usersList = await usersListRepository.getUsersListResponse();
            usersList.isEmpty
                ? emit(state.copyWith(hasReachedMax: true))
                : emit(state.copyWith(
                    status: UserStatus.success,
                    users: List.of(state.users)..addAll(usersList),
                    hasReachedMax: false));
          }
        } catch (e) {
          emit(state.copyWith(
              status: UserStatus.error, errorMessage: "failed to fetch posts"));
        }
      }
    }, transformer: droppable());
  }
}
