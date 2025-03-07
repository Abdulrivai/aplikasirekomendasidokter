import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 150, // Bisa ubah ukuran di sini
          height: 150,
          child: Image.asset('assets/healtmatelogo.png'),
        ),
      ),
    );
  }
}
