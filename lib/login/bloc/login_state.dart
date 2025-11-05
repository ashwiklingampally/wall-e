part of 'login_bloc.dart';

final class LoginState extends Equatable {
  final String email;

  final String password;

  final bool isValid;
  final ApiStatus status;
  final String? emailErrorMessage;
  final String? passwordErrorMessage;

  const LoginState({
    this.email = '',
    this.password = '',
    this.isValid = false,
    this.status = ApiStatus.initial,
    this.emailErrorMessage,
    this.passwordErrorMessage
  });

  LoginState copyWith({
    String? email,
    String? password,
    bool? isValid,
    ApiStatus? status,
    String? emailErrorMessage,
    String? passwordErrorMessage,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isValid: isValid ?? this.isValid,
      emailErrorMessage: emailErrorMessage?? this.emailErrorMessage,
      status: status ?? this.status,
      passwordErrorMessage: passwordErrorMessage?? this.passwordErrorMessage
    );
  }

  @override
  List<Object?> get props => [email, password, status, isValid, emailErrorMessage,passwordErrorMessage];
}
