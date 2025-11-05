part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

final class EmailChanged extends LoginEvent {
  const EmailChanged({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

final class PasswordChanged extends LoginEvent {
  const PasswordChanged({required this.password});

  final String password;

  @override
  List<Object> get props => [password];
}

final class SubmitClicked extends LoginEvent {
  const SubmitClicked();
  @override
  List<Object> get props => [];
}

final class LoginWithGoogle extends LoginEvent {
  const LoginWithGoogle();
  @override
  List<Object> get props => [];
}