import 'package:carrot_flutter/src/models/user_model.dart';
import 'package:carrot_flutter/src/providers/user_provider.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final provider = Get.put(UserProvider());
  final Rx<UserModel?> my = Rx<UserModel?>(null);

  Future<void> myInfo() async {
    Map body = await provider.show();
    if (body['result'] == 'ok') {
      my.value = UserModel.parse(body['data']);
      return;
    }
    Get.snackbar('회원 에러', body['message'], snackPosition: SnackPosition.BOTTOM);
  }

  Future<bool> updateInfo(String name, int? image) async {
    Map body = await provider.update(name, image);
    if (body['result'] == 'ok') {
      my.value = UserModel.parse(body['data']);
      return true;
    }
    Get.snackbar('수정 에러', body['message'], snackPosition: SnackPosition.BOTTOM);
    return false;
  }
}