import 'package:equatable/equatable.dart';

abstract class PhoneNumberEvent extends Equatable {
  const PhoneNumberEvent();

  @override
  List<Object?> get props => [];
}

/// Fired whenever the user types/changes the mobile number.
class PhoneNumberChangedEvent extends PhoneNumberEvent {
  final String phoneNumber;

  const PhoneNumberChangedEvent(this.phoneNumber);

  @override
  List<Object?> get props => [phoneNumber];
}

/// Fired when the user clicks Continue.
class SendOtpButtonPressedEvent extends PhoneNumberEvent {
  const SendOtpButtonPressedEvent();
}

/// Used when returning back to this page or restarting this flow.
class ResetPhoneNumberEvent extends PhoneNumberEvent {
  const ResetPhoneNumberEvent();
}
