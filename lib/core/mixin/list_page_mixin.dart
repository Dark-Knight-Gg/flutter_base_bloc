import 'package:flutter/material.dart';
import 'package:flutter_base_bloc/core/mixin/page_mixin.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../bloc/base_list_bloc.dart';
import '../bloc/state_wrapper.dart';
import '../pull_refresh/refresh_event.dart';
import '../pull_refresh/refresh_helper.dart';

mixin BaseListPageMixin<V, C extends BaseListCubit<V>> on PageMixin<V, C> {
  final RefreshController refreshController = RefreshController();

  Widget generateList(
    BuildContext context,
    Widget child, {
    bool? enablePullUp,
    bool? enablePullDown,
    RefreshController? controller,
  }) {
    return SmartRefresher(
      enablePullUp: enablePullUp ?? true,
      enablePullDown: enablePullDown ?? true,
      controller: controller ?? refreshController,
      onRefresh: () => cubit(context).refresh(),
      onLoading: () => cubit(context).onLoadMore(),
      child: child,
    );
  }

  @override
  void handleListener(BuildContext context, StateWrapper<V> state) {
    final event = state.event;
    if (event is RefreshEvent) {
      RefreshHelper.handleRefresh(refreshController, event);
      return;
    }
    super.handleListener(context, state);
  }
}
