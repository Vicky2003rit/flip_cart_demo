import 'package:equatable/equatable.dart';

abstract class WelcomeEvent extends Equatable {
  const WelcomeEvent();

  @override
  List<Object?> get props => [];
}

/// Fired when user presses "Create Account".
class CreateAccountButtonPressed extends WelcomeEvent {
  const CreateAccountButtonPressed();
}

/// Fired when user presses "Log In".
class LoginButtonPressed extends WelcomeEvent {
  const LoginButtonPressed();
}
class ResetWelcomeEvent extends WelcomeEvent {
  const ResetWelcomeEvent();
}