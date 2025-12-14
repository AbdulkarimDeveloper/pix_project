import 'package:flutter/material.dart';
import 'package:pixa_project/modules/models/user_model.dart';
import 'package:pixa_project/modules/repositories/register_repository.dart';
import 'package:pixa_project/utils/profile_data.dart';
import 'package:pixa_project/utils/router/router_generator.dart';
import 'package:pixa_project/utils/router/routers.dart';
import 'package:toastification/toastification.dart';

class RegisterViewModel extends ChangeNotifier {
  RegisterViewModel({required this.repository});
  RegisterRepositoryAbs repository;

  Future<void> register(UserModel model, BuildContext context) async {
    final list = await repository.getAll();

    bool res = true;
    for (var item in list) {
      if (item.email == model.email && item.username == model.username) {
        res = false;
      }
    }

    if (res == false) {
      toastification.show(
        // ignore: use_build_context_synchronously
        context: context,
        title: Text('This user is already exists in system !'),
        type: ToastificationType.error,
        autoCloseDuration: const Duration(seconds: 4),
      );
      return;
    }

    bool isAdded = await repository.add(model);
    if (isAdded) {
      ProfileData.instance.set(model);
      RouteGenerator.routerClient.goNamed(Routers.homeName);
    }
  }
}
