import 'package:flip_cart_demo/features/auth/phone_number_screen/pages/phone_number_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/account_method_bloc.dart';
import '../bloc/account_method_event.dart';
import '../bloc/account_method_state.dart';

class AccountMethodPage extends StatelessWidget {
  const AccountMethodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountMethodBloc, AccountMethodState>(
      listener: (context, state) {
        if (state.status == AccountMethodStatus.phoneSelected) {
          debugPrint('Phone number method selected');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const PhoneNumberPage(),
            ),
          );
          if (context.mounted) {
    context.read<AccountMethodBloc>().add(
          const ResetAccountMethodEvent(),
        );
  }

          // Next step:
          // Navigate to PhoneNumberPage.
        }

        if (state.status == AccountMethodStatus.emailSelected) {
          debugPrint('Email method selected');

          // Next step:
          // Navigate to EmailPage.
        }
      },
      child: const _AccountMethodView(),
    );
  }
}

class _AccountMethodView extends StatelessWidget {
  const _AccountMethodView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
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
              const Text(
                'Create your account',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1D1D1D),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Choose how you want to continue with Flip Cart.',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.45,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 42),
              _MethodButton(
                icon: Icons.phone_outlined,
                title: 'Continue with Phone Number',
                subtitle: 'Receive a secure OTP to verify your number.',
                isPrimary: true,
                onTap: () {
                  context.read<AccountMethodBloc>().add(
                        const PhoneMethodSelectedEvent(),
                      );
                },
              ),
              const SizedBox(height: 16),
              _MethodButton(
                icon: Icons.email_outlined,
                title: 'Continue with Email',
                subtitle: 'Create an account using your email address.',
                isPrimary: false,
                onTap: () {
                  context.read<AccountMethodBloc>().add(
                        const EmailMethodSelectedEvent(),
                      );
                },
              ),
              const Spacer(),
              Text(
                'By continuing, you agree to our Terms of Service and Privacy Policy.',
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
    );
  }
}

class _MethodButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isPrimary;
  final VoidCallback onTap;

  const _MethodButton({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isPrimary,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor =
        isPrimary ? const Color(0xFF2874F0) : Colors.grey.shade300;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: isPrimary ? const Color(0xFFE8F1FF) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: borderColor,
            width: isPrimary ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color:
                    isPrimary ? const Color(0xFF2874F0) : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: isPrimary ? Colors.white : const Color(0xFF2874F0),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1D1D1D),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.35,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: Color(0xFF2874F0),
            ),
          ],
        ),
      ),
    );
  }
}
