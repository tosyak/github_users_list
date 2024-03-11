import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:github_test_app/data/models/user_detail_model.dart';
import 'package:github_test_app/data/repository/api_repository.dart';

part 'user_details_bloc_event.dart';
part 'user_details_bloc_state.dart';

class UserDetailsBloc extends Bloc<UserDetailsEvent, UserDetailsState> {
  // Injection of a repository for fetching user details
  final UserDetailsRepository userDetailsRepository;

  // Constructor, initiating with UserDetailsInitial state
  UserDetailsBloc(this.userDetailsRepository) : super(UserDetailsInitial()) {
    on<GetUserDetailsEvent>((event, emit) async {
      // Emit a loading state to indicate ongoing retrieval
      emit(GithubUserDetailsLoading());

      try {
        // Attempt to fetch user details from the repository
        final UserDetails userDetails =
            await userDetailsRepository.getUserDetailsResponse(event.username);

        // Emit a loaded state with the fetched data
        emit(UserDetailsLoaded(userDetails));
      } catch (e) {
        // Handle any errors and emit an error state with a message
        emit(UserDetailsError(e.toString()));
      }
    });
  }
}
