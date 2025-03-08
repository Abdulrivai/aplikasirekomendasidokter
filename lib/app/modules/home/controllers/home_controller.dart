import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //Firebase Initialize
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //listener untuk mengetahui apakah user sudah login atau belum
  @override
  void onInit() {
    _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        Get.offNamed('/login');
      }
    });
    super.onInit();
  }

  void logout() async {
    await _auth.signOut();
    Get.offNamed('/login');
  }
}
