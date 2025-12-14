import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:pixa_project/modules/models/user_model.dart';
import 'package:pixa_project/modules/repositories/login_repository.dart';
import 'package:pixa_project/utils/profile_data.dart';
import 'package:pixa_project/utils/router/router_generator.dart';
import 'package:pixa_project/utils/router/routers.dart';
import 'package:toastification/toastification.dart';

class LoginViewModel {
  LoginViewModel({required this.repository});
  LoginRepositoryAbs repository;

  Future<void> login(
    UserModel model,
    BuildContext context,
  ) async {
    final list = await repository.getAll();

    bool res = false;
    for (var item in list) {
      if (item.email == model.email && item.password == model.password) {
        res = true;
      }
    }

    if (res == false) {
      toastification.show(
        // ignore: use_build_context_synchronously
        context: context,
        title: Text('This user is not exists in system !'),
        type: ToastificationType.error,
        autoCloseDuration: const Duration(seconds: 4),
      );
      return;
    }

    final userModel = list.firstWhereOrNull(
      (item) => item.email == model.email && item.password == model.password,
    );

    if (userModel != null) {
      ProfileData.instance.set(userModel);
      RouteGenerator.routerClient.goNamed(Routers.homeName);
    }
  }
}
