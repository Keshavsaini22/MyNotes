import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'dart:developer' as devtools show log;
import 'package:minenotes/constants/routes.dart';
import 'package:minenotes/services/auth/auth_exception.dart';
// import 'package:minenotes/services/auth/auth_service.dart';
import 'package:minenotes/services/auth/bloc/auth_bloc.dart';
import 'package:minenotes/services/auth/bloc/auth_event.dart';
import 'package:minenotes/services/auth/bloc/auth_state.dart';
import '../utilities/dialog/error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration:
                const InputDecoration(hintText: 'Enter your email here'),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration:
                const InputDecoration(hintText: 'Enter your password here'),
          ),
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) async {
              if (state is AuthStateLoggedOut) {
                if (state.exception is UserNotFoundException) {
                  await showErrorDialog(context, 'User not found');
                } else if (state.exception is WrongPasswordAuthException) {
                  await showErrorDialog(context, 'Wrong credentials');
                } else if (state.exception is GenericAuthException) {
                  await showErrorDialog(context, 'Authentication error');
                }
              }
            },
            child: TextButton(
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;
                context.read<AuthBloc>().add(
                      AuthEventLogIn(
                        email,
                        password,
                      ),
                    );
                //During CH-40
                // try {
                //   await AuthService.firebase().logIn(
                //     email: email,
                //     password: password,
                //   );
                //   final user = AuthService.firebase().currentUser;
                //   if (user?.isEmailVerified ?? false) {
                //     //user's email is verified
                //     // ignore: use_build_context_synchronously
                //     Navigator.of(context).pushNamedAndRemoveUntil(
                //       notesRoute,
                //       (route) => false,
                //     );
                //   } else {
                //     //user's email is not varified
                //     // ignore: use_build_context_synchronously
                //     Navigator.of(context).pushNamedAndRemoveUntil(
                //       verifyEmailRoute,
                //       (route) => false,
                //     );
                //   }
                // } on UserNotFoundException {
                //   await showErrorDialog(
                //     context,
                //     'User not found',
                //   );
                // } on WeakPasswordAuthException {
                //   await showErrorDialog(
                //     context,
                //     'Wrong credentials',
                //   );
                // } on GenericAuthException {
                //   await showErrorDialog(
                //     context,
                //     'Authentication Error',
                //   );
                // }
              },
              child: const Text('Login'),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(registerRoute, (route) => false);
            },
            child: const Text('Not registerd yet? Register here!'),
          )
        ],
      ),
    );
  }
}
