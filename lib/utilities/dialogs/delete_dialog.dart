import 'package:flutter/widgets.dart';
import 'package:ghj/utilities/dialogs/generic_dialog.dart';

Future<bool> showDeleteDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Delete',
    content: 'Are you sure you want to delete this item?',
    optionsBuilder: () => {'cancel': false, 'Yes': true},
  ).then((value) => value ?? false);
}
