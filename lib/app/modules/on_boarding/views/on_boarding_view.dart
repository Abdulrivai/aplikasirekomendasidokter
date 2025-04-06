import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../controllers/on_boarding_controller.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final OnBoardingController controller = Get.put(OnBoardingController());

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min, // Agar sesuai ukuran kontennya
          children: [
            Image.asset(
              'assets/hmlogo.png', // Ganti dengan path logo PNG Anda
              height: 32, // Sesuaikan ukuran logo
            ),
            const SizedBox(width: 8), // Jarak antara logo dan teks
            const Text(
              'Healtmate', // Ganti dengan nama aplikasi Anda
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue, // Membuat teks tebal
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: controller.pageController,
              itemCount: controller.onboardingData.length,
              onPageChanged: controller.updatePageIndex,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      controller.onboardingData[index]['image']!,
                      // Tidak ada height atau fit, gunakan ukuran asli
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(child: CircularProgressIndicator());
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(Icons.broken_image,
                              size: 50, color: Colors.grey),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    Text(
                      controller.onboardingData[index]['title']!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        controller.onboardingData[index]['description']!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                GetBuilder<OnBoardingController>(
                  builder: (controller) => SmoothPageIndicator(
                    controller: controller.pageController,
                    count: controller.onboardingData.length,
                    effect: ExpandingDotsEffect(
                      activeDotColor: Colors.blue,
                      dotHeight: 8,
                      dotWidth: 8,
                    ),
                    onDotClicked: (index) {
                      controller.pageController.animateToPage(
                        index,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                      controller.updatePageIndex(index);
                    },
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => TextButton(
                        onPressed: controller.currentIndex.value == 0
                            ? null
                            : controller.previousPage,
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.blue, // Warna teks biru
                        ),
                        child: Text(
                          "Back",
                          style: TextStyle(
                            color: Colors.blue, // Warna teks biru
                            fontWeight: FontWeight
                                .bold, // (Opsional) Tambahkan ketebalan teks
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: controller.skipToEnd,
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.blue, // Warna teks biru
                      ),
                      child: Text(
                        "Skip",
                        style: TextStyle(
                          color: Colors.blue, // Warna teks biru
                          fontWeight: FontWeight
                              .bold, // (Opsional) Menambahkan ketebalan teks
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: controller.nextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Warna tombol
                    foregroundColor: Colors.white, // Warna teks
                    minimumSize:
                        Size(double.infinity, 50), // Lebar penuh, tinggi 50
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(12), // Sudut melengkung
                    ),
                    elevation: 6, // Efek bayangan
                    shadowColor:
                        Colors.black.withOpacity(0.3), // Warna bayangan
                  ),
                  child: Text(
                    "Mulai Tanyakan Dokter",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
