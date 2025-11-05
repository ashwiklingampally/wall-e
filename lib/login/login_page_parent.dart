import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:wall_e/login/bloc/login_bloc.dart';
import 'package:wall_e/login/view/login_page_mobile.dart';

import '../repository/authentication_repository.dart';

class LoginPageParent extends StatelessWidget {
  const LoginPageParent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (_) => LoginBloc(
        authenticationRepository: context.read<AuthenticationRepository>(),
      ),
      child: ScreenTypeLayout.builder(
        mobile: (BuildContext context) => LoginPageMobile(),
        tablet: (BuildContext context) => LoginPageMobile(),
        desktop: (BuildContext context) => LoginPageMobile(),
      ),
    );
  }
}
