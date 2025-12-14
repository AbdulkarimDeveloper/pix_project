import 'package:pixa_project/core/local/storage_abs.dart';
import 'package:pixa_project/core/local/storage_keys.dart';
import 'package:pixa_project/modules/models/user_model.dart';

abstract class RegisterRepositoryAbs {
  Future<List<UserModel>> getAll();
  Future<bool> add(UserModel model);
}

class RegisterRepositoryImpl extends RegisterRepositoryAbs {
  RegisterRepositoryImpl({required this.storage});
  final StorageAbs<UserModel> storage;

  final _key = StorageKeys.users;

  @override
  Future<List<UserModel>> getAll() async {
    return storage.getAll(_key, UserModel.parseFromString);
  }

  @override
  Future<bool> add(UserModel model) async {
    return storage.add(
      _key,
      model,
      UserModel.parseFromString,
      UserModel.parseToString,
    );
  }
}
