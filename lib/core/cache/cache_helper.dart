abstract class CacheHelper {
  bool containsKey(String key);

  void put(String key, dynamic value);

  V get<V>(String key, {V? defaultValue});

  void delete(String key);

  void clear();
}
