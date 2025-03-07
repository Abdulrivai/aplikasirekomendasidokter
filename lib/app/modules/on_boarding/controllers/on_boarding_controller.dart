import 'package:get/get.dart';
import 'package:flutter/material.dart';

class OnBoardingController extends GetxController {
  final pageController = PageController();
  final currentIndex = 0.obs;

  final List<Map<String, String>> onboardingData = [
    {
      'image': 'assets/banneronboard1.png',
      'title': 'Judul Pertama',
      'description': 'Deskripsi onboarding pertama.',
    },
    {
      'image': 'assets/banneronboard1.png',
      'title': 'Judul Kedua',
      'description': 'Deskripsi onboarding kedua.',
    },
    {
      'image': 'assets/banneronboard1.png',
      'title': 'Judul Ketiga',
      'description': 'Deskripsi onboarding ketiga.',
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
