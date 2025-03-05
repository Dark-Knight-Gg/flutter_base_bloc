import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../bloc/base_bloc.dart';
import '../bloc/state_wrapper.dart';
import '../dialog/dialog_event.dart';
import '../dialog/dialog_helper.dart';
import '../logger/app_logger.dart';
import '../navigation/navigate_event.dart';
import '../navigation/navigator_helper.dart';
import '../progress/progress_event.dart';
import '../progress/progress_helper.dart';
import '../toast/toast_event.dart';
import '../toast/toast_helper.dart';
import '../widget/multi_state_view_widget.dart';

mixin PageMixin<V, C extends BaseCubit<V>> {
  void handleListener(BuildContext context, StateWrapper<V> state) {
    AppLogger.log('$runtimeType: handleListener, $state');
    var event = state.event;
    if (event is NavigateEvent) {
      NavigatorHelper.navigate(event, (response) {
        cubit(context).onEventResult(event, response);
      });
      return;
    }
    if (event is ToastEvent) {
      var toast = FToast().init(context);
      ToastHelper.showToast(toast, event);
      return;
    }
    if (event is ProgressEvent) {
      ProgressHelper.handleProgressDialog(context, event);
      return;
    }
    if (event is DialogEvent) {
      DialogHelper.show(context, event);
      return;
    }
  }

  Widget buildRoot() {
    return BlocConsumer<C, StateWrapper<V>>(
      listenWhen: (previous, current) => previous.event != current.event,
      listener: handleListener,
      buildWhen: (previous, current) =>
          previous.viewState != current.viewState ||
          previous.message != current.message ||
          previous.value != current.value,
      builder: buildMain,
    );
  }

  Widget buildMain(BuildContext context, StateWrapper<V> state) {
    AppLogger.log('$runtimeType: buildMain, $state');
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: buildAppBar(context, state),
        backgroundColor: backgroundColor(),
        body: buildBody(context, state),
      ),
    );
  }

  Future<bool> onWillPop() async => true;

  PreferredSizeWidget? buildAppBar(
    BuildContext context,
    StateWrapper<V> state,
  ) {
    return null;
  }

  Widget buildBody(BuildContext context, StateWrapper<V> state) {
    return MultiStateViewWidget(
      viewState: state.viewState,
      loadingWidget: buildLoading(state),
      emptyWidget: buildEmpty(state),
      errorWidget: buildError(state),
      message: message(state),
      onRetryPress: onRetryPress(context),
      child: buildContent(context, state),
    );
  }

  Widget buildContent(BuildContext context, StateWrapper<V> state) {
    return Center(child: Text("New screen $runtimeType"));
  }

  Widget? buildLoading(StateWrapper<V> state) => null;

  Widget? buildEmpty(StateWrapper<V> state) => null;

  Widget? buildError(StateWrapper<V> state) => null;

  String? message(StateWrapper<V> state) => state.message;

  VoidCallback? onRetryPress(BuildContext context) =>
      () => cubit(context).refresh();

  Color? backgroundColor() => null;

  C cubit(BuildContext context) => context.read<C>();
}
