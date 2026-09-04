import 'package:equatable/equatable.dart';

enum AccountMethodStatus {
  initial,
  phoneSelected,
  emailSelected,
}

class AccountMethodState extends Equatable {
  final AccountMethodStatus status;

  const AccountMethodState({
    this.status = AccountMethodStatus.initial,
  });

  AccountMethodState copyWith({
    AccountMethodStatus? status,
  }) {
    return AccountMethodState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}
