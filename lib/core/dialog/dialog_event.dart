import 'dart:ui';

import '../../generated/l10n.dart';

enum DialogActionType { positive, negative }

class DialogAction {
  final DialogActionType type;
  final String text;
  final VoidCallback? onTap;

  DialogAction({
    required this.type,
    required this.text,
    this.onTap,
  });

  DialogAction.positive({
    required String text,
    VoidCallback? onTap,
  }) : this(
          type: DialogActionType.positive,
          text: text,
          onTap: onTap,
        );

  DialogAction.negative({
    required String text,
    VoidCallback? onTap,
  }) : this(
          type: DialogActionType.negative,
          text: text,
          onTap: onTap,
        );
}

class DialogEvent {
  final String? tag;
  final String? title;
  final String? content;
  final bool? dismissible;
  final VoidCallback? onDismiss;
  final List<DialogAction> actions;

  DialogEvent({
    this.tag,
    this.title,
    this.content,
    this.dismissible = false,
    this.onDismiss,
    this.actions = const [],
  });

  DialogEvent.alert({
    String? title,
    String? content,
    bool? dismissible,
    VoidCallback? onDismiss,
    String? action,
    VoidCallback? onActionTap,
  }) : this(
          title: title,
          content: content,
          dismissible: dismissible,
          onDismiss: onDismiss,
          actions: [
            DialogAction.positive(
              text: action ?? BS.current.ok,
              onTap: onActionTap,
            )
          ],
        );

  DialogEvent.confirm({
    String? title,
    String? content,
    bool? dismissible,
    VoidCallback? onDismiss,
    String? negativeAction,
    String? positiveAction,
    VoidCallback? onNegativeActionTap,
    VoidCallback? onPositiveActionTap,
  }) : this(
          title: title,
          content: content,
          dismissible: dismissible,
          onDismiss: onDismiss,
          actions: [
            DialogAction.negative(
              text: negativeAction ?? BS.current.cancel,
              onTap: onNegativeActionTap,
            ),
            DialogAction.positive(
              text: positiveAction ?? BS.current.ok,
              onTap: onPositiveActionTap,
            )
          ],
        );
}
