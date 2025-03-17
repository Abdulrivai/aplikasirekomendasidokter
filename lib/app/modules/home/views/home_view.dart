import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:floating_draggable_widget/floating_draggable_widget.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/hmlogo.png', height: 32),
            const SizedBox(width: 8),
            const Text(
              'Healtmate',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: FloatingDraggableWidget(
        autoAlign: true,
        mainScreenWidget: SingleChildScrollView(
          child: Column(
            children: [
              // Stack untuk banner dan kartu yang mengambang
              Stack(
                alignment: Alignment.topCenter,
                clipBehavior:
                    Clip.none, // Agar kartu bisa keluar dari batas Stack
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/bank-sampah-1ef03.appspot.com/o/caridokter%2Fbekgroundhealt.png?alt=media&token=3d2d1d98-0af3-4bd5-a734-3ef4cecca284',
                      width: double.infinity,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(child: CircularProgressIndicator());
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                            child: Icon(Icons.broken_image,
                                size: 50, color: Colors.grey));
                      },
                    ),
                  ),
                  // Kartu informasi dokter spesialis mengambang di atas banner
                  Positioned(
                    top: 180, // Mengatur kartu agar sedikit di atas banner
                    left: 20,
                    right: 20,
                    child: Card(
                      color: Colors.white.withOpacity(0.9),
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/jumlahdoktor.png', height: 32),
                            const SizedBox(width: 8),
                            const Text(
                              'Terdapat ',
                              style: TextStyle(
                                  fontSize: 13, color: Colors.black87),
                            ),
                            const Text(
                              '180',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                            const Text(
                              ' Dokter Spesialis Di Aplikasi ini',
                              style: TextStyle(
                                  fontSize: 13, color: Colors.black87),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                  height:
                      60), // Jarak untuk mencegah tumpang tindih dengan konten di bawah
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1,
                  ),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    List<String> categories = [
                      'assets/booking.png',
                      'assets/obat.png',
                      'assets/rs.png',
                      'assets/ambulan.png',
                    ];
                    List<String> categoryNames = [
                      'Booking',
                      'Obat',
                      'RS Terdekat',
                      'Darurat',
                    ];
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Image.asset(categories[index],
                              height: 60, width: 60),
                        ),
                        const SizedBox(height: 5),
                        Text(categoryNames[index],
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold)),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Obx(() {
                if (controller.newsList.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.newsList.length,
                  itemBuilder: (context, index) {
                    var news = controller.newsList[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Container(
                        width: double
                            .infinity, // Ubah sesuai kebutuhan (contoh: 300 untuk lebar spesifik)
                        height:
                            110, // Ubah sesuai kebutuhan (contoh: 150 untuk lebih tinggi)
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.blue.shade50,
                              Colors.white
                            ], // Gradien halus
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Gambar
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: news["image"]!.isNotEmpty
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        news["image"]!,
                                        width:
                                            80, // Ubah ukuran gambar sesuai kebutuhan
                                        height: 80,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return const Icon(
                                              Icons.image_not_supported,
                                              size: 80);
                                        },
                                      ),
                                    )
                                  : const Icon(Icons.image_not_supported,
                                      size: 80, color: Colors.grey),
                            ),
                            // Konten teks
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      news["title"]!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            16, // Ubah ukuran font sesuai kebutuhan
                                        color: Colors.black87,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      '${news["publisher"]} • ${news["date"]}',
                                      style: TextStyle(
                                        fontSize:
                                            12, // Ubah ukuran font sesuai kebutuhan
                                        color: Colors.grey.shade600,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Tombol bookmark
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: IconButton(
                                icon: const Icon(Icons.bookmark_border,
                                    color: Colors.blue),
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text('Saved: ${news["title"]}')),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ],
          ),
        ),
        floatingWidget: Image.asset('assets/floatingicons.png', height: 120),
        floatingWidgetHeight: 120,
        floatingWidgetWidth: 120,
      ),
    );
  }
}
