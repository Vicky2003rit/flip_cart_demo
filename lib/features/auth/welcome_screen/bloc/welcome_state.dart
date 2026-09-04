import 'package:equatable/equatable.dart';

enum WelcomeStatus {
  initial,
  createAccountRequested,
  loginRequested,
}

class WelcomeState extends Equatable {
  final WelcomeStatus status;

  const WelcomeState({
    this.status = WelcomeStatus.initial,
  });

  WelcomeState copyWith({
    WelcomeStatus? status,
  }) {
    return WelcomeState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}