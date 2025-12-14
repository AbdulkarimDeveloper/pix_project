import 'package:pixa_project/modules/models/user_model.dart';

class ProfileData {
  static final ProfileData _singleton = ProfileData._();
  static ProfileData get instance => _singleton;
  ProfileData._();

  UserModel? model;

  set(UserModel model) {
    this.model = model;
  }

  clear() {
    model = null;
  }
}
