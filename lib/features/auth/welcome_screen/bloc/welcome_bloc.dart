import 'package:flutter_bloc/flutter_bloc.dart';

import 'welcome_event.dart';
import 'welcome_state.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super(const WelcomeState()) {
    on<CreateAccountButtonPressed>(_onCreateAccountButtonPressed);
    on<LoginButtonPressed>(_onLoginButtonPressed);
    on<ResetWelcomeEvent>(_onResetWelcome);
  }

  void _onCreateAccountButtonPressed(
    CreateAccountButtonPressed event,
    Emitter<WelcomeState> emit,
  ) {
    emit(
      state.copyWith(
        status: WelcomeStatus.createAccountRequested,
      ),
    );
  }

  void _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<WelcomeState> emit,
  ) {
    emit(
      state.copyWith(
        status: WelcomeStatus.loginRequested,
      ),
    );
  }

  void _onResetWelcome(
    ResetWelcomeEvent event,
    Emitter<WelcomeState> emit,
  ) {
    emit(
      state.copyWith(
        status: WelcomeStatus.initial,
      ),
    );
  }
}
