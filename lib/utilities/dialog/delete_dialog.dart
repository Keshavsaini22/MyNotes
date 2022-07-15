import 'package:flutter/material.dart';
import 'package:minenotes/utilities/dialog/generic_dialog.dart';

Future<bool> showDeleteDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Delete',
    content: 'Are you sure you want to delete this item?',
    optionsBuilder: () => {
      'Cancle': false,
      'Yes': true,
    },
  ).then(
    (value) => value ?? false,
  );
}
