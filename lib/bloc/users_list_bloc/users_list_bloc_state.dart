part of 'users_list_bloc_bloc.dart';

class UsersListState extends Equatable {
  final UserStatus status;
  final List<User> users;
  final bool hasReachedMax;
  final String errorMessage;

  const UsersListState(
      {this.status = UserStatus.loading,
      this.hasReachedMax = false,
      this.users = const [],
      this.errorMessage = ""});

  UsersListState copyWith({
    UserStatus? status,
    List<User>? users,
    bool? hasReachedMax,
    String? errorMessage,
  }) {
    return UsersListState(
      status: status ?? this.status,
      users: users ?? this.users,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, users, hasReachedMax, errorMessage];
}
