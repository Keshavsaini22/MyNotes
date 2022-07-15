import 'package:flutter/material.dart';
import 'package:minenotes/utilities/dialog/generic_dialog.dart';

Future<bool> showLogOutDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Log out',
    content: 'Are you sure you want to log out?',
    optionsBuilder: () => {
      'Cancle': false,
      'Lou out': true,
    },
  ).then(
    (value) => value ?? false,
  );
}
