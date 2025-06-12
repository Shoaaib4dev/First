import 'package:flutter/widgets.dart';
import 'package:ghj/utilities/dialogs/generic_dialog.dart';

Future<bool> showLogOutDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Log out',
    content: 'Are you sure you want to log out?',
    optionsBuilder: () => {'cancel': false, 'Log out': true},
  ).then((value) => value ?? false);
}
