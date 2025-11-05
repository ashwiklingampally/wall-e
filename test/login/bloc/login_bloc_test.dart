import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wall_e/login/bloc/login_bloc.dart';
import 'package:wall_e/repository/authentication_repository.dart';
import 'package:wall_e/utils/api_status.dart';

Future<void> main() async{
  group('CounterBloc', () {
    blocTest(
      'emits state when CounterIncrementPressed is added',
      build: () =>
          LoginBloc(authenticationRepository: AuthenticationRepository()),
      act: (bloc) => bloc.add(EmailChanged(email: 'ashwik@gmail.com')),
      expect: () => [
        LoginState().copyWith(
          emailErrorMessage: null,
          email: 'ashwik@gmail.com',
          status: ApiStatus.initial,
          passwordErrorMessage: null
        ),
      ],
    );
  });
}
