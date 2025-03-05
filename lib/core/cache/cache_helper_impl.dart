import 'package:hive_flutter/hive_flutter.dart';

import 'cache_helper.dart';

class HiveCacheHelper implements CacheHelper {
  static Box? _box;

  static Future<bool> initialize() async {
    await Hive.initFlutter();
    _box = await Hive.openBox("CacheHelper");
    return true;
  }

  @override
  bool containsKey(String key) {
    return _box?.containsKey(key) ?? false;
  }

  @override
  void put(String key, value) {
    _box?.put(key, value);
  }

  @override
  V get<V>(String key, {V? defaultValue}) {
    return _box?.get(key, defaultValue: defaultValue) ?? defaultValue;
  }

  @override
  void delete(String key) {
    _box?.delete(key);
  }

  @override
  void clear() {
    _box?.clear();
  }
}
