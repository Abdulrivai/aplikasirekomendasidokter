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
        Get.snackbar("Error", "No user found for that email.");
        throw 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        Get.snackbar("Error", "Wrong password provided for that user.");
        throw 'Wrong password provided for that user.';
      } else if (e.code == 'invalid-credential') {
        Get.snackbar("Error",
            "The supplied auth credential is incorrect, malformed, or has expired.");
        throw 'The supplied auth credential is incorrect, malformed, or has expired.';
      } else {
        Get.snackbar("Error", "An error occurred while login.");
        throw 'An error occurred while login.';
      }
    }
  }

  void register() {
    Get.offNamed('/register');
  }
}
