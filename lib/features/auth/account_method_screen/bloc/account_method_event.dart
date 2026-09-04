import 'package:equatable/equatable.dart';

abstract class AccountMethodEvent extends Equatable {
  const AccountMethodEvent();

  @override
  List<Object?> get props => [];
}

/// User selects phone-number registration.
class PhoneMethodSelectedEvent extends AccountMethodEvent {
  const PhoneMethodSelectedEvent();
}

/// User selects email registration.
class EmailMethodSelectedEvent extends AccountMethodEvent {
  const EmailMethodSelectedEvent();
}

/// Resets the state when user returns to this page.
/// This allows Phone/Email selection to work again.
class ResetAccountMethodEvent extends AccountMethodEvent {
  const ResetAccountMethodEvent();
}
