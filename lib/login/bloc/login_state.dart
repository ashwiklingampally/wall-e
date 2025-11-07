part of 'login_bloc.dart';

final class LoginState extends Equatable {
  final String email;

  final String password;
  final ApiStatus status;
  final String? emailErrorMessage;
  final String? passwordErrorMessage;

  bool get isValid =>
      email.isNotEmpty &&
      password.isNotEmpty &&
      emailErrorMessage == null &&
      passwordErrorMessage == null;

  const LoginState({
    this.email = StringExtensions.emptyString,
    this.password = StringExtensions.emptyString,
    this.status = ApiStatus.initial,
    this.emailErrorMessage,
    this.passwordErrorMessage,
  });

  LoginState copyWith({
    String? email,
    String? password,
    ApiStatus? status,
    String? emailErrorMessage,
    String? passwordErrorMessage,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      emailErrorMessage: emailErrorMessage,
      status: status ?? this.status,
      passwordErrorMessage: passwordErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
    email,
    password,
    status,
    isValid,
    emailErrorMessage,
    passwordErrorMessage,
  ];
}
