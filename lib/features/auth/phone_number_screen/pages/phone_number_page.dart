import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/phone_number_bloc.dart';
import '../bloc/phone_number_event.dart';
import '../bloc/phone_number_state.dart';

class PhoneNumberPage extends StatefulWidget {
  const PhoneNumberPage({super.key});

  @override
  State<PhoneNumberPage> createState() => _PhoneNumberPageState();
}

class _PhoneNumberPageState extends State<PhoneNumberPage> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PhoneNumberBloc, PhoneNumberState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == PhoneNumberStatus.otpRequested) {
          debugPrint('OTP requested for: +91${state.phoneNumber}');

          /*
            Next step:

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => OtpVerificationPage(
                  phoneNumber: '+91${state.phoneNumber}',
                ),
              ),
            );
          */
        }

        if (state.status == PhoneNumberStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errorMessage ?? 'Unable to send OTP. Try again.',
              ),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              context.read<PhoneNumberBloc>().add(
                    const ResetPhoneNumberEvent(),
                  );

              Navigator.pop(context);
            },
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 22),
                Container(
                  height: 64,
                  width: 64,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F1FF),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.phone_iphone_outlined,
                    color: Color(0xFF2874F0),
                    size: 32,
                  ),
                ),
                const SizedBox(height: 28),
                const Text(
                  'Verify your mobile number',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1D1D1D),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Enter your mobile number. We will send a one-time password (OTP) for verification.',
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.45,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 38),
                const Text(
                  'Mobile Number',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1D1D1D),
                  ),
                ),
                const SizedBox(height: 8),
                BlocBuilder<PhoneNumberBloc, PhoneNumberState>(
                  buildWhen: (previous, current) =>
                      previous.status != current.status ||
                      previous.errorMessage != current.errorMessage,
                  builder: (context, state) {
                    final hasError =
                        state.status == PhoneNumberStatus.invalidNumber;

                    return TextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      onChanged: (value) {
                        context.read<PhoneNumberBloc>().add(
                              PhoneNumberChangedEvent(value),
                            );
                      },
                      decoration: InputDecoration(
                        counterText: '',
                        hintText: 'Enter 10-digit mobile number',
                        errorText: hasError ? state.errorMessage : null,
                        prefixIcon: Container(
                          alignment: Alignment.center,
                          width: 70,
                          child: const Text(
                            '+91',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1D1D1D),
                            ),
                          ),
                        ),
                        prefixIconConstraints: const BoxConstraints(
                          minWidth: 70,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: hasError ? Colors.red : Colors.grey.shade300,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color:
                                hasError ? Colors.red : const Color(0xFF2874F0),
                            width: 1.5,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 22),
                BlocBuilder<PhoneNumberBloc, PhoneNumberState>(
                  buildWhen: (previous, current) =>
                      previous.status != current.status ||
                      previous.phoneNumber != current.phoneNumber,
                  builder: (context, state) {
                    final isLoading =
                        state.status == PhoneNumberStatus.sendingOtp;

                    // Button is enabled only if the number has exactly 10 digits
                    // and OTP is not currently being sent.
                    final canContinue = state.isPhoneNumberValid && !isLoading;

                    return SizedBox(
                      height: 52,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: canContinue
                            ? () {
                                context.read<PhoneNumberBloc>().add(
                                      const SendOtpButtonPressedEvent(),
                                    );
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2874F0),
                          foregroundColor: Colors.white,
                          disabledBackgroundColor:
                              const Color(0xFF2874F0).withOpacity(0.55),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: isLoading
                            ? const SizedBox(
                                height: 22,
                                width: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                'Continue',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    );
                  },
                ),
                const Spacer(),
                Text(
                  'By continuing, you agree to Flip Cart’s Terms of Service and Privacy Policy.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.4,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
