import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:wall_e/login/bloc/login_bloc.dart';
import 'package:wall_e/login/view/login_page_mobile.dart';
import 'package:wall_e/repository/authentication_repository.dart';

void main(){
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
group('login flow', (){
  setUpAll(() async{
    testWidgets('description', (tester)async{
      await tester.pumpWidget(MaterialApp(home: BlocProvider<LoginBloc>(
          create: (_) => LoginBloc(
            authenticationRepository: AuthenticationRepository(),
          ),
          child: LoginPageMobile())));
    });
  });
  testWidgets('email validations check', (WidgetTester tester) async{
// tester.tap(find.byKey(Key('loginForm_emailInput_textField')));
tester.enterText(find.byKey(Key('loginForm_emailInput_textField')), 'ashwik');
tester.pumpAndSettle();
expect(find.text('Invalid email'),findsOne);
  });
});
}