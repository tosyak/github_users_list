import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:github_test_app/utils/logger.dart';

part 'splash_bloc_event.dart';
part 'splash_bloc_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  //  Initialize the bloc with the initial state (SplashInitial).
  SplashBloc() : super(SplashInitial()) {
    //  Define a handler for the SplashCheck event.
    on<SplashCheck>(checkNetwork);
  }

  //  Function to check network connectivity and emit appropriate states.
  void checkNetwork(SplashEvent event, Emitter<SplashState> emit) async {
    try {
      //  Retrieve network connection status.
      final bool networkIsConnected =
          await InternetConnectionChecker().hasConnection;

      //  Emit state based on connection status.
      if (networkIsConnected) {
        emit(SplashNetworkConnected());
      } else {
        emit(SplashNetworkNotConnected());
      }
    } catch (e) {
      //  Log any errors and throw a generic exception for clarity.
      logger.e('Splash Cubit app init error');
      throw Exception('Splash Cubit app init error');
    }
  }
}
