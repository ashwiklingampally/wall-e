import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wall_e/login/bloc/login_bloc.dart';
import 'package:wall_e/utils/api_status.dart';

class LoginPageMobile extends StatelessWidget {
  const LoginPageMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        listenWhen: (previousState, currentState) {
          return currentState.status == ApiStatus.success;
        },
        listener: (context, state) {
          if (state.status == ApiStatus.success) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Login Successful')));
          }
        },
        builder: (context, state) {
          return state.status == ApiStatus.inProgress
              ? const Center(child: CircularProgressIndicator())
              : Align(
                  alignment: const Alignment(0, -1 / 3),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FlutterLogo(size: 120),
                        const SizedBox(height: 16),
                        _EmailInput(),
                        const SizedBox(height: 8),
                        _PasswordInput(),
                        const SizedBox(height: 8),
                        _LoginButton(),
                        const SizedBox(height: 8),
                        _GoogleLoginButton(),
                        const SizedBox(height: 4),
                        _SignUpButton(),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key('loginForm_emailInput_textField'),
      onChanged: (email) =>
          context.read<LoginBloc>().add(EmailChanged(email: email)),
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'email',
        helperText: '',
        errorText: context.select(
          (LoginBloc bloc) => bloc.state.emailErrorMessage,
        ),
      ),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key('loginForm_passwordInput_textField'),
      onChanged: (password) =>
          context.read<LoginBloc>().add(PasswordChanged(password: password)),
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'password',
        helperText: '',
        errorText: context.select(
          (LoginBloc bloc) => bloc.state.passwordErrorMessage,
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool isValid = context.select(
      (LoginBloc bloc) =>
          bloc.state.email.isNotEmpty &&
          bloc.state.password.isNotEmpty &&
          bloc.state.passwordErrorMessage == null &&
          bloc.state.emailErrorMessage == null,
    );

    return ElevatedButton(
      key: const Key('loginForm_continue_raisedButton'),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: isValid
            ? const Color(0xFFFFD600)
            : const Color(0xFFB0BDAE),
      ),
      onPressed: isValid
          ? () => context.read<LoginBloc>().add(SubmitClicked())
          : null,
      child: const Text('LOGIN'),
    );
  }
}

class _GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton.icon(
      key: const Key('loginForm_googleLogin_raisedButton'),
      label: const Text(
        'SIGN IN WITH GOOGLE',
        style: TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: theme.colorScheme.secondary,
      ),
      icon: const Icon(FontAwesomeIcons.google, color: Colors.white),
      onPressed: () => context.read<LoginBloc>().add(LoginWithGoogle())
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextButton(
      key: const Key('loginForm_createAccount_flatButton'),
      onPressed: () => {},
      child: Text(
        'CREATE ACCOUNT',
        style: TextStyle(color: theme.primaryColor),
      ),
    );
  }
}
