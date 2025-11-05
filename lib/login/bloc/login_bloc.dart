import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wall_e/repository/authentication_repository.dart';
import 'package:wall_e/utils/api_status.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required AuthenticationRepository authenticationRepository,
  }) : _authenticationRepository = authenticationRepository,
        super(const LoginState()){

    on<EmailChanged>(_onEmailChanged);
    on<SubmitClicked>(_onFormSubmitted);
    on<PasswordChanged>(_onPasswordChanged);
  }
  final AuthenticationRepository _authenticationRepository;

  void _onEmailChanged(EmailChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(emailErrorMessage: getErrorMessage(event.email),email: event.email,status: ApiStatus.initial));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(passwordErrorMessage: getPasswordMessage(event.password),password: event.password,status: ApiStatus.initial));
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
        isValid: true,
        status: ApiStatus.inProgress,
      ),
    );
    try{
      var status = await _authenticationRepository.logIn(
        email: state.email,
        password: state.password,
      );
      emit(
        state.copyWith(
          email: email,
          password: password,
          isValid: true,
          status: status,
        ),
      );
    }catch(e){
      emit(state.copyWith(status: ApiStatus.failure,emailErrorMessage: e.toString()),);
    }





    await Future<void>.delayed(const Duration(seconds: 5));
    emit(
      state.copyWith(
        email: "",
        password: "",
        isValid: true,
        status: ApiStatus.success,
      ),
    );
  }

  String? getErrorMessage(String email) {
    return email.contains("@") ? "" : "Invalid Email";
  }

  String? getPasswordMessage(String password) {
    return password.isNotEmpty ? null : "password cant be empty";
  }

  Future<void> _logInWithGoogle() async {
    // try {
    //   await _authenticationRepository.logInWithGoogle();
    //   emit(state.withSubmissionSuccess());
    // } on LogInWithGoogleFailure catch (e) {
    //   emit(state.withSubmissionFailure(e.message));
    // } catch (_) {
    //   emit(state.withSubmissionFailure());
    // }

}
}
