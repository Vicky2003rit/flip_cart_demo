import 'package:flip_cart_demo/features/auth/account_method_screen/pages/account_method_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/welcome_bloc.dart';
import '../bloc/welcome_event.dart';
import '../bloc/welcome_state.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<WelcomeBloc, WelcomeState>(
      listener: (context, state) {
        if (state.status == WelcomeStatus.createAccountRequested) {
          debugPrint('Create account clicked');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AccountMethodPage(),
            ),
          );
          if (context.mounted) {
            context.read<WelcomeBloc>().add(
                  const ResetWelcomeEvent(),
                );
          }

          // Next:
          // context.read<AuthFlowBloc>().add(
          //   const OpenAccountMethodEvent(),
          // );
        }

        if (state.status == WelcomeStatus.loginRequested) {
          debugPrint('Login clicked');

          // Later:
          // context.read<AuthFlowBloc>().add(
          //   const OpenLoginEvent(),
          // );
        }
      },
      child: const _WelcomeView(),
    );
  }
}

class _WelcomeView extends StatelessWidget {
  const _WelcomeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 20,
          ),
          child: Column(
            children: [
              const Spacer(),
              Container(
                height: 96,
                width: 96,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F1FF),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Icon(
                  Icons.shopping_bag_outlined,
                  size: 52,
                  color: Color(0xFF2874F0),
                ),
              ),
              const SizedBox(height: 28),
              const Text(
                'Welcome to Flip Cart',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1D1D1D),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Discover products, save your favourites, and shop with confidence.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.45,
                  color: Colors.grey.shade600,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<WelcomeBloc>().add(
                          const CreateAccountButtonPressed(),
                        );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2874F0),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton(
                  onPressed: () {
                    context.read<WelcomeBloc>().add(
                          const LoginButtonPressed(),
                        );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF2874F0),
                    side: const BorderSide(
                      color: Color(0xFF2874F0),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Log In',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 22),
              Text(
                'By continuing, you agree to our Terms of Service and Privacy Policy.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  height: 1.4,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
