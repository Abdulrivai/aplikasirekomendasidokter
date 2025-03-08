import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;

  // Firebase Initialize
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //listener untuk mengetahui apakah user sudah login atau belum
  @override
  void onInit() {
    _auth.authStateChanges().listen((User? user) {
      if (user != null) {
        Get.offNamed('/home');
      }
    });
    super.onInit();
  }

  void login() async {
    try {
      if (email.value.isEmpty || password.value.isEmpty) {
        Get.snackbar("Error", "Semua field harus diisi");
      }
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );
      Get.snackbar("Success", "Login berhasil");

      Get.offNamed('/home');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        Get.snackbar("Error", "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        Get.snackbar("Error", "Wrong password provided for that user.");
      } else if (e.code == 'invalid-credential') {
        print(
            'The supplied auth credential is incorrect, malformed, or has expired.');
        Get.snackbar("Error",
            "The supplied auth credential is incorrect, malformed, or has expired.");
      } else {
        print('Error: $e');
      }
    }
  }

  void register() {
    Get.offNamed('/register');
  }
}
