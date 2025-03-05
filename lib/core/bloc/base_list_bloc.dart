import 'package:flutter/material.dart';
import 'package:flutter_base_bloc/core/bloc/state_wrapper.dart';
import 'package:flutter_base_bloc/core/mixin/page_mixin.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../configs/constants.dart';
import '../pull_refresh/refresh_event.dart';
import '../pull_refresh/refresh_helper.dart';
import 'base_bloc.dart';

abstract class BaseListCubit<V> extends BaseCubit<V> {
  BaseListCubit.value(super.value) : super.value();

  BaseListCubit.create(super.initialState) : super.create();

  int _page = Constants.firstPage;

  int get page => _page;

  int get firstPage => Constants.firstPage;

  int get limit => Constants.limit;

  @override
  void start() {
    super.start();
    _page = firstPage;
  }

  @override
  void refresh() {
    _page = firstPage;
  }

  void onLoadMore() {}

  void emitRefreshToIdle() {
    emitNewEvent(RefreshEvent.refreshToIdle());
  }

  void emitLoadComplete() {
    _page++;
    emitNewEvent(RefreshEvent.loadComplete());
  }

  void emitLoadFailed() {
    emitNewEvent(RefreshEvent.loadFailed());
  }

  void emitLoadNoData() {
    emitNewEvent(RefreshEvent.loadNoData());
  }

  bool isRefresh() => page == firstPage;

  bool isLoadMore() => page > firstPage;

  void emitNewLoadState({List? newData, String? exception}) {
    if (exception != null) {
      if (isRefresh()) {
        emitRefreshToIdle();
        showError(exception);
      } else {
        emitLoadFailed();
      }
      return;
    }
    if (newData != null) {
      final dataLength = newData.length;
      if (isRefresh()) {
        emitRefreshToIdle();
        if (dataLength == 0) {
          showEmpty();
        } else {
          showContent();
        }
      }
      if (dataLength < limit) {
        emitLoadNoData();
      } else {
        emitLoadComplete();
      }
    }
  }
}

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
