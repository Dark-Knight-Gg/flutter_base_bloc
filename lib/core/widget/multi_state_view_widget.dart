import 'package:flutter/material.dart';
import 'package:flutter_base_bloc/core/widget/defalut_state_widget.dart';

import '../bloc/view_state.dart';

class MultiStateViewWidget extends StatelessWidget {
  final Widget child;
  final ViewState? viewState;
  final Widget? loadingWidget;
  final Widget? emptyWidget;
  final Widget? errorWidget;
  final String? message;
  final VoidCallback? onRetryPress;

  const MultiStateViewWidget({
    super.key,
    required this.child,
    this.viewState,
    this.loadingWidget,
    this.emptyWidget,
    this.errorWidget,
    this.message,
    this.onRetryPress,
  });

  @override
  Widget build(BuildContext context) {
    final currentViewState = viewState ?? ViewState.content;
    if (currentViewState == ViewState.content) {
      return child;
    }
    return DefaultStateWidget(
      viewState: currentViewState,
      message: message,
      onRetryPress: onRetryPress,
    );
  }
}
