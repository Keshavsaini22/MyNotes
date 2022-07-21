import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'dart:developer' as devtools show log;
// import 'package:minenotes/constants/routes.dart';
import 'package:minenotes/services/auth/auth_exception.dart';
// import 'package:minenotes/services/auth/auth_service.dart';
import 'package:minenotes/services/auth/bloc/auth_bloc.dart';
import 'package:minenotes/services/auth/bloc/auth_event.dart';
import 'package:minenotes/services/auth/bloc/auth_state.dart';
// import 'package:minenotes/utilities/dialog/loading_dialog.dart';
import '../utilities/dialog/error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  // CloseDialog? _closedDialogHandle;

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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateLoggedOut) {
          // final closeDailog = _closedDialogHandle;
          // if (!state.isLoading && closeDailog != null) {
          //   closeDailog();
          //   _closedDialogHandle = null;
          // } else if (state.isLoading && closeDailog == null) {
          //   _closedDialogHandle = showLoadingDialog(
          //     context: context,
          //     text: 'Loading...',
          //   );
          // }

          if (state.exception is UserNotFoundException) {
            await showErrorDialog(
                context, 'Cannot find a user with the entered credentials!');
          } else if (state.exception is WrongPasswordAuthException) {
            await showErrorDialog(context, 'Wrong credentials');
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(context, 'Authentication error');
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  'Please log in to your account in order to interact with and create notes!',
                ),
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
                  decoration: const InputDecoration(
                      hintText: 'Enter your password here'),
                ),
                TextButton(
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
                TextButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(
                          const AuthEventForgotPassword(),
                        );
                  },
                  child: const Text('I forgot my password'),
                ),
                TextButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(
                          const AuthEventShouldRegister(),
                        );
                    // Navigator.of(context)
                    //     .pushNamedAndRemoveUntil(registerRoute, (route) => false);
                  },
                  child: const Text('Not registerd yet? Register here!'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
