import 'package:flutter/material.dart';

import 'dialog_event.dart';
import 'dialog_widget.dart';

abstract class DialogHelper {
  static Future<void> show(BuildContext context, DialogEvent event) async {
    await showDialog(
      context: context,
      barrierDismissible: event.dismissible ?? false,
      builder: (BuildContext context) {
        return DialogWidget(event: event);
      },
    );
    event.onDismiss?.call();
  }
}
