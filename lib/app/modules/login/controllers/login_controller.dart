import 'package:get/get.dart';

class LoginController extends GetxController {
  void login() {
    Get.offNamed('/home');
  }

  void register() {
    Get.offNamed('/register');
  }
}
