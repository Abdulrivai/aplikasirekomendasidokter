import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  var username = ''.obs;
  var email = ''.obs;
  var password = ''.obs;
  var confirmPassword = ''.obs;

  //firebase initialize
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void register() async {
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
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );
      saveToFirestore();
      Get.offNamed('/login');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        throw 'The account already exists for that email.';
      } else if (e.code == 'invalid-password') {
        throw 'The password is invalid.';
      } else if (e.code == 'invalid-email') {
        throw 'The email is invalid.';
      } else {
        throw 'An error occurred while creating the user.';
      }
    }
    Get.snackbar("Success", "Registrasi berhasil");
  }

  void saveToFirestore() async {
    final User? user = _auth.currentUser;
    final Map<String, dynamic> userModel = {
      'uid': user!.uid,
      'username': username.value,
      'email': email.value,
    };
    try {
      await _firestore.collection('users').doc(user.uid).set(userModel);
    } on FirebaseException catch (e) {
      throw 'Error: $e';
    }
  }
}
