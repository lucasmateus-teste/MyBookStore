abstract interface class LocalStorage {
  String? get(String key);
  Future<void> save(String key, String value);
  Future<void> remove(String key);
  Future<void> clear();
  bool containsKey(String key);
}
