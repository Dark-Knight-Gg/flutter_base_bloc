enum RefreshType {
  refreshToIdle,
  loadComplete,
  loadFailed,
  loadNoData,
}

class RefreshEvent {
  final RefreshType type;

  RefreshEvent._(this.type);

  RefreshEvent.refreshToIdle() : this._(RefreshType.refreshToIdle);

  RefreshEvent.loadComplete() : this._(RefreshType.loadComplete);

  RefreshEvent.loadFailed() : this._(RefreshType.loadFailed);

  RefreshEvent.loadNoData() : this._(RefreshType.loadNoData);
}
