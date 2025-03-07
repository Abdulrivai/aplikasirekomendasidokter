import 'package:get/get.dart';

class RegisterController extends GetxController {
  var username = ''.obs;
  var email = ''.obs;
  var password = ''.obs;
  var confirmPassword = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void register() {
    if (username.value.isEmpty ||
        email.value.isEmpty ||
        password.value.isEmpty ||
        confirmPassword.value.isEmpty) {
      Get.snackbar("Error", "Semua field harus diisi");
      return;
    }
    if (password.value != confirmPassword.value) {
      Get.snackbar("Error", "Password tidak cocok");
      return;
    }
    // Tambahkan logika registrasi ke backend atau database di sini
    Get.snackbar("Success", "Registrasi berhasil");
  }
}
