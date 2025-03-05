import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../bloc/view_state.dart';
import '../configs/constants_widget.dart';

class DefaultStateWidget extends StatelessWidget {
  const DefaultStateWidget({
    super.key,
    this.viewState,
    this.message,
    this.onRetryPress,
  });

  final ViewState? viewState;
  final String? message;
  final VoidCallback? onRetryPress;

  @override
  Widget build(BuildContext context) {
    switch (viewState ?? ViewState.content) {
      case ViewState.loading:
        return _defaultLoadingWidget();
      case ViewState.empty:
        return  _defaultEmptyWidget();
      case ViewState.error:
        return _defaultErrorWidget();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _defaultLoadingWidget() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _defaultEmptyWidget() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.warning_amber_rounded,
            size: 32,
            color: Colors.amber,
          ),
          height12,
          Text(
            message ?? BS.current.data_not_found,
            textAlign: TextAlign.center,
          ),
          height5,
          _buildRetryButton(),
        ],
      ),
    );
  }

  Widget _defaultErrorWidget() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.error_outline_sharp,
            size: 32,
            color: Colors.red,
          ),
          height12,
          Text(
            message ?? BS.current.something_went_wrong,
            textAlign: TextAlign.center,
          ),
          height5,
          _buildRetryButton(),
        ],
      ),
    );
  }

  Widget _buildRetryButton() {
    if (onRetryPress == null) return emptyView;
    return TextButton(
      onPressed: onRetryPress,
      child: Text(BS.current.retry),
    );
  }
}
