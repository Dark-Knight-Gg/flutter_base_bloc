import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'refresh_event.dart';

abstract class RefreshHelper {
  static void handleRefresh(RefreshController controller, RefreshEvent event) {
    switch (event.type) {
      case RefreshType.refreshToIdle:
        controller.refreshToIdle();
        break;
      case RefreshType.loadComplete:
        controller.loadComplete();
        break;
      case RefreshType.loadFailed:
        controller.loadFailed();
        break;
      case RefreshType.loadNoData:
        controller.loadNoData();
        break;
    }
  }
}
