import 'package:pixa_project/core/local/storage_abs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageImpl<T> extends StorageAbs<T> {
  @override
  Future<bool> add(
    String key,
    T item,
    List<T> Function(String data) parseFromString,
    String Function(List<T> list) parseToString,
  ) async {
    final storage = await SharedPreferences.getInstance();
    final data = storage.getString(key);

    List<T> items = data == null ? [] : parseFromString(data);
    items.add(item);

    await storage.setString(key, parseToString(items));
    return true;
  }

  @override
  Future<bool> update(
    String key,
    T item,
    List<T> Function(String data) parseFromString,
    String Function(List<T> list) parseToString,
    dynamic Function(T item) compareTo,
  ) async {
    final storage = await SharedPreferences.getInstance();
    final data = await storage.getString(key);
    if (data == null) {
      return false;
    }

    List<T> items = parseFromString(data);
    int index = items.indexWhere(
      (element) => compareTo(element) == compareTo(item),
    );
    if (index <= -1) {
      return false;
    }

    items[index] = item;
    await storage.setString(key, parseToString(items));

    return true;
  }

  @override
  Future<bool> delete(
    String key,
    T item,
    List<T> Function(String data) parseFromString,
    String Function(List<T> list) parseToString,
    dynamic Function(T item) compareTo,
  ) async {
    final storage = await SharedPreferences.getInstance();
    final data = await storage.getString(key);
    if (data == null) {
      return false;
    }

    List<T> items = parseFromString(data);
    int index = items.indexWhere(
      (element) => compareTo(element) == compareTo(item),
    );
    if (index <= -1) {
      return false;
    }

    items.removeAt(index);
    await storage.setString(key, parseToString(items));

    return true;
  }

  @override
  Future<List<T>> getAll(
    String key,
    List<T> Function(String data) parseFromString,
  ) async {
    final storage = await SharedPreferences.getInstance();
    final data = await storage.getString(key);
    if (data == null) {
      return [];
    }

    List<T> items = parseFromString(data);
    return items;
  }

  @override
  Future<bool> addAll(
    String key,
    List<T> items,
    List<T> Function(String data) parseFromString,
    String Function(List<T> list) parseToString,
  ) async {
    final storage = await SharedPreferences.getInstance();
    final data = await storage.getString(key);

    List<T> oldItems = data == null ? [] : parseFromString(data);
    oldItems.addAll(items);

    await storage.setString(key, parseToString(oldItems));

    return true;
  }
}
