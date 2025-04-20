import 'package:flutter/foundation.dart';
import 'package:my_book_store/src/core/exceptions/my_book_store_exceptions.dart';
import 'package:my_book_store/src/core/local_storage/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefLocalStorage implements LocalStorage {
  SharedPrefLocalStorage({required this.sharedPreferences});

  @protected
  final SharedPreferences sharedPreferences;

  @override
  Future<void> clear() async {
    final isSuccess = await sharedPreferences.clear();
    if (!isSuccess) throw MyBookStoreException('Failed to clear storage');
  }

  @override
  bool containsKey(String key) => sharedPreferences.containsKey(key);

  @override
  String? get(String key) => sharedPreferences.getString(key);

  @override
  Future<void> remove(String key) async {
    final isSuccess = await sharedPreferences.remove(key);
    if (!isSuccess) throw MyBookStoreException('Failed to remove key: $key');
  }

  @override
  Future<void> save(String key, String value) async {
    final isSuccess = await sharedPreferences.setString(key, value);
    if (!isSuccess) throw MyBookStoreException('Failed to save key: $key');
  }
}
