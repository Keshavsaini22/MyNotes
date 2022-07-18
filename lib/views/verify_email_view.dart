import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:minenotes/constants/routes.dart';
// import 'package:minenotes/services/auth/auth_service.dart';
import 'package:minenotes/services/auth/bloc/auth_bloc.dart';
import 'package:minenotes/services/auth/bloc/auth_event.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify email'),
      ),
      body: Column(
        children: [
          const Text(
              "We've sent you an email verification.Please open it to verify your account"),
          const Text(
              "If you haven't received a verifiaction email yet, press the button below"),
          TextButton(
            onPressed: () {
              context.read<AuthBloc>().add(
                    const AuthEventSendEmailVerification(),
                  );
              // await AuthService.firebase().sendEmailVerification();
            },
            child: const Text('Send email verification'),
          ),
          TextButton(
            onPressed: () async {
              context.read<AuthBloc>().add(
                    const AuthEventLogOut(),
                  );
              // await AuthService.firebase().logOut();

              // // ignore: use_build_context_synchronously
              // Navigator.of(context).pushNamedAndRemoveUntil(
              //   registerRoute,
              //   (route) => false,
              // );
            },
            child: const Text('Restart'),
          )
        ],
      ),
    );
  }
}
