import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wall_e/di/di.dart';
import 'package:wall_e/login/bloc/login_bloc.dart';
import 'package:wall_e/login/view/login_page_mobile.dart';
import 'package:wall_e/data/repository/authentication_repository_impl.dart';

void main() {
  group('description', () {
    testWidgets('test', (tester) async {
      await tester.pumpWidget(MaterialApp(home: BlocProvider<LoginBloc>(
          create: (_) => LoginBloc(authenticationRepository: sl()
          ),
          child: LoginPageMobile())));
      expect(find.byKey(Key('loginForm_emailInput_textField')), findsOneWidget);
    });
  });
}
