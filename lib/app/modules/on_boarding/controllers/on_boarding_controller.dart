import 'package:get/get.dart';
import 'package:flutter/material.dart';

class OnBoardingController extends GetxController {
  final pageController = PageController();
  final currentIndex = 0.obs;

  final List<Map<String, String>> onboardingData = [
    {
      'image': 'assets/banneronboard1.png',
      'title': 'Konsultasi Tepat dengan Dokter Spesialis',
      'description':
          'Dapatkan rekomendasi dokter spesialis yang sesuai dengan keluhan kesehatan Anda. Chatbot kami akan membantu menemukan pilihan terbaik dalam hitungan detik!.',
    },
    {
      'image': 'assets/banneronboard1.png',
      'title': 'Cepat, Mudah, dan Akurat',
      'description':
          'Tak perlu bingung memilih dokter! Jawab beberapa pertanyaan singkat, dan chatbot pintar kami akan memberikan rekomendasi yang sesuai dengan kebutuhan Anda.',
    },
    {
      'image': 'assets/banneronboard1.png',
      'title': 'Akses Kesehatan dalam Genggaman',
      'description':
          'Cari dokter spesialis kapan saja dan di mana saja. Rekomendasi yang dipersonalisasi membuat pengalaman konsultasi lebih praktis dan efisien.',
    },
  ];

  void updatePageIndex(int index) {
    currentIndex.value = index;
  }

  void nextPage() {
    if (currentIndex.value < onboardingData.length - 1) {
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void previousPage() {
    if (currentIndex.value > 0) {
      pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void skipToEnd() {
    pageController.jumpToPage(onboardingData.length - 1);
  }
}
