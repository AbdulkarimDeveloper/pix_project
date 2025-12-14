import 'dart:convert';

import 'package:pixa_project/modules/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

String _key = 'user_storage';

class AppStorage {
  const AppStorage();

  Future<UserModel?> get() async {
    final storage = await SharedPreferences.getInstance();
    final data = storage.getString(_key);
    if (data == null) {
      return null;
    }

    return UserModel.fromJson(json.decode(data));
  }

  Future<bool> set(UserModel model) async {
    final storage = await SharedPreferences.getInstance();
    return storage.setString(_key, json.encode(model.toJson()));
  }

  clear() async {
    (await SharedPreferences.getInstance()).clear();
  }
}
