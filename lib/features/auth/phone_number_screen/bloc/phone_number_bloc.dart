import 'package:flip_cart_demo/features/auth/phone_number_screen/bloc/phone_number_event.dart';
import 'package:flip_cart_demo/features/auth/phone_number_screen/bloc/phone_number_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhoneNumberBloc extends Bloc<PhoneNumberEvent, PhoneNumberState> {
  PhoneNumberBloc() : super(const PhoneNumberState()) {
    on<PhoneNumberChangedEvent>(_onPhoneNumberChanged);
    on<SendOtpButtonPressedEvent>(_onSendOtpButtonPressed);
    on<ResetPhoneNumberEvent>(_onResetPhoneNumber);
  }

  void _onPhoneNumberChanged(
    PhoneNumberChangedEvent event,
    Emitter<PhoneNumberState> emit,
  ) {
    final phoneNumber = event.phoneNumber.trim();

    if (phoneNumber.isEmpty) {
      emit(
        state.copyWith(
          phoneNumber: phoneNumber,
          status: PhoneNumberStatus.initial,
          clearErrorMessage: true,
        ),
      );
      return;
    }

    if (RegExp(r'^[0-9]{10}$').hasMatch(phoneNumber)) {
      emit(
        state.copyWith(
          phoneNumber: phoneNumber,
          status: PhoneNumberStatus.validNumber,
          clearErrorMessage: true,
        ),
      );
    } else {
      emit(
        state.copyWith(
          phoneNumber: phoneNumber,
          status: PhoneNumberStatus.invalidNumber,
          errorMessage: 'Enter a valid 10-digit mobile number',
        ),
      );
    }
  }

  Future<void> _onSendOtpButtonPressed(
    SendOtpButtonPressedEvent event,
    Emitter<PhoneNumberState> emit,
  ) async {
    if (!state.isPhoneNumberValid) {
      emit(
        state.copyWith(
          status: PhoneNumberStatus.invalidNumber,
          errorMessage: 'Enter a valid 10-digit mobile number',
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: PhoneNumberStatus.sendingOtp,
        clearErrorMessage: true,
      ),
    );

    /*
      Firebase OTP code will be added in the next step.

      Later, call FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${state.phoneNumber}',
        ...
      );
    */

    // Temporary success state for navigation testing.
    await Future.delayed(const Duration(milliseconds: 500));

    emit(
      state.copyWith(
        status: PhoneNumberStatus.otpRequested,
      ),
    );
  }

  void _onResetPhoneNumber(
    ResetPhoneNumberEvent event,
    Emitter<PhoneNumberState> emit,
  ) {
    emit(const PhoneNumberState());
  }
}
