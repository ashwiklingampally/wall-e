import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wall_e/domain/repository/authentication_repository.dart';
import 'package:wall_e/utils/api_status.dart';
import 'package:wall_e/utils/string_extensions.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required AuthenticationRepository authenticationRepository})
    : _authenticationRepository = authenticationRepository,
      super(const LoginState()) {
    on<EmailChanged>(_onEmailChanged);
    on<SubmitClicked>(_onFormSubmitted);
    on<PasswordChanged>(_onPasswordChanged);
    on<LoginWithGoogle>(_onLoginWithGoogle);
  }

  final AuthenticationRepository _authenticationRepository;

  void _onEmailChanged(EmailChanged event, Emitter<LoginState> emit) {
    emit(
      state.copyWith(
        emailErrorMessage: getErrorMessage(event.email),
        email: event.email,
        status: ApiStatus.initial,
      ),
    );
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    emit(
      state.copyWith(
        passwordErrorMessage: getPasswordMessage(event.password),
        password: event.password,
        status: ApiStatus.initial,
      ),
    );
  }

  Future<void> _onFormSubmitted(
    SubmitClicked event,
    Emitter<LoginState> emit,
  ) async {
    final email = state.email;
    final password = state.password;
    emit(
      state.copyWith(
        email: email,
        password: password,
        status: ApiStatus.inProgress,
      ),
    );
    try {
      var status = await _authenticationRepository.logIn(
        email: state.email,
        password: state.password,
      );
      emit(state.copyWith(email: email, password: password, status: status));
    } catch (e) {
      emit(
        state.copyWith(
          status: ApiStatus.failure,
          emailErrorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onLoginWithGoogle(
    LoginWithGoogle event,
    Emitter<LoginState> emit,
  ) async {
    var user = await _authenticationRepository.googleLogIn();
    print(user.toString());
  }

  String? getErrorMessage(String email) {
    return email.contains("@") ? null : "Invalid Email";
  }

  String? getPasswordMessage(String password) {
    return password.isNotEmpty ? null : "password cant be empty";
  }
}
