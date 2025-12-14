import 'package:get_it/get_it.dart';
import 'package:pixa_project/core/local/storage_abs.dart';
import 'package:pixa_project/core/local/storage_impl.dart';
import 'package:pixa_project/core/remote/api_service.dart';
import 'package:pixa_project/modules/models/user_model.dart';
import 'package:pixa_project/modules/repositories/home_repository.dart';
import 'package:pixa_project/modules/repositories/login_repository.dart';
import 'package:pixa_project/modules/repositories/register_repository.dart';
import 'package:pixa_project/modules/view_models/home_view_model.dart';
import 'package:pixa_project/modules/view_models/login_view_model.dart';
import 'package:pixa_project/modules/view_models/register_view_model.dart';

final getIt = GetIt.instance;

Future initInjection() async {
  getIt.registerLazySingleton<StorageAbs<UserModel>>(
    () => StorageImpl<UserModel>(),
  );
  getIt.registerLazySingleton<ApiService>(() => ApiService());

  //Login
  getIt.registerLazySingleton<LoginRepositoryAbs>(
    () => LoginRepositoryImpl(storage: getIt()),
  );
  getIt.registerLazySingleton<LoginViewModel>(
    () => LoginViewModel(repository: getIt()),
  );

  //Register
  getIt.registerLazySingleton<RegisterRepositoryAbs>(
    () => RegisterRepositoryImpl(storage: getIt()),
  );
  getIt.registerLazySingleton<RegisterViewModel>(
    () => RegisterViewModel(repository: getIt()),
  );

  //Home
  getIt.registerLazySingleton<HomeRepositoryAbs>(
    () => HomeRepositoryImpl(apiService: getIt()),
  );
  getIt.registerLazySingleton<HomeViewModel>(
    () => HomeViewModel(repository: getIt()),
  );
}
