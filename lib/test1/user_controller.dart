import 'package:get/get.dart';

import 'model/user.dart';

class UserController extends GetxController {
  final user = User().obs;

  updateUser(int count) {
    return user.update((val) {
      val?.name = "Saliou";
      val?.count = count;
    });
  }
}
