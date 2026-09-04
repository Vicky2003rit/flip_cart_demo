import 'package:equatable/equatable.dart';

enum PhoneNumberStatus {
  initial,
  invalidNumber,
  validNumber,
  sendingOtp,
  otpRequested,
  failure,
}

class PhoneNumberState extends Equatable {
  final String phoneNumber;
  final PhoneNumberStatus status;
  final String? errorMessage;

  const PhoneNumberState({
    this.phoneNumber = '',
    this.status = PhoneNumberStatus.initial,
    this.errorMessage,
  });

  bool get isPhoneNumberValid {
    return RegExp(r'^[0-9]{10}$').hasMatch(phoneNumber);
  }

  PhoneNumberState copyWith({
    String? phoneNumber,
    PhoneNumberStatus? status,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return PhoneNumberState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      status: status ?? this.status,
      errorMessage:
          clearErrorMessage ? null : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        phoneNumber,
        status,
        errorMessage,
      ];
}
