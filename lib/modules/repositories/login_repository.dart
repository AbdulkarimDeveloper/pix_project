import 'package:pixa_project/core/local/storage_abs.dart';
import 'package:pixa_project/core/local/storage_keys.dart';
import 'package:pixa_project/modules/models/user_model.dart';

abstract class LoginRepositoryAbs {
  Future<List<UserModel>> getAll();
}

class LoginRepositoryImpl extends LoginRepositoryAbs {
  LoginRepositoryImpl({required this.storage});
  final StorageAbs<UserModel> storage;

  final _key = StorageKeys.users;

  @override
  Future<List<UserModel>> getAll() async {
    return storage.getAll(_key, UserModel.parseFromString);
  }
}
