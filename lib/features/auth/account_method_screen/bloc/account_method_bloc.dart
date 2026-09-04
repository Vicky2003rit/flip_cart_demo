import 'package:flutter_bloc/flutter_bloc.dart';

import 'account_method_event.dart';
import 'account_method_state.dart';

class AccountMethodBloc extends Bloc<AccountMethodEvent, AccountMethodState> {
  AccountMethodBloc() : super(const AccountMethodState()) {
    on<PhoneMethodSelectedEvent>(_onPhoneMethodSelected);
    on<EmailMethodSelectedEvent>(_onEmailMethodSelected);
    on<ResetAccountMethodEvent>(_onResetAccountMethod);
  }

  void _onPhoneMethodSelected(
    PhoneMethodSelectedEvent event,
    Emitter<AccountMethodState> emit,
  ) {
    emit(
      state.copyWith(
        status: AccountMethodStatus.phoneSelected,
      ),
    );
  }

  void _onEmailMethodSelected(
    EmailMethodSelectedEvent event,
    Emitter<AccountMethodState> emit,
  ) {
    emit(
      state.copyWith(
        status: AccountMethodStatus.emailSelected,
      ),
    );
  }

  void _onResetAccountMethod(
    ResetAccountMethodEvent event,
    Emitter<AccountMethodState> emit,
  ) {
    emit(
      state.copyWith(
        status: AccountMethodStatus.initial,
      ),
    );
  }
}
