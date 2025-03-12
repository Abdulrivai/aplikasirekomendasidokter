import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:floating_draggable_widget/floating_draggable_widget.dart';
import '../controllers/home_controller.dart';

class GlassButton extends StatelessWidget {
  final String text;
  final Function() onPressed;

  const GlassButton({required this.text, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: MaterialButton(
        onPressed: onPressed,
        splashColor: Colors.lightBlue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(36)),
        padding: EdgeInsets.zero,
        child: Ink(
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: NetworkImage(
                "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/finance_app_2%2FbuttonBackgroundSmall.png?alt=media&token=fa2f9bba-120a-4a94-8bc2-f3adc2b58a73",
              ),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(36),
          ),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/hmlogo.png',
              height: 32,
            ),
            const SizedBox(width: 8),
            const Text(
              'Healtmate',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: FloatingDraggableWidget(
        autoAlign: true,
        mainScreenWidget: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/bank-sampah-1ef03.appspot.com/o/caridokter%2Fbekgroundhealt.png?alt=media&token=3d2d1d98-0af3-4bd5-a734-3ef4cecca284',
                            width: double.infinity,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const Center(
                                  child: CircularProgressIndicator());
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                child: Icon(
                                  Icons.broken_image,
                                  size: 50,
                                  color: Colors.grey,
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 60),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
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
                                    onTap: () {
                                      // Aksi ketika kategori dipilih
                                    },
                                    child: Image.asset(
                                      categories[index],
                                      height: 60,
                                      width: 60,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    categoryNames[index],
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GlassButton(
                    text: 'Tanyakan Dokter Sekarang',
                    onPressed: () => controller.logout(),
                  ),
                ),
              ],
            ),
            Positioned(
              top: MediaQuery.of(context).size.width / 2.2,
              left: 20,
              right: 20,
              child: Card(
                color: Colors.white.withOpacity(0.9),
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/jumlahdoktor.png',
                        height: 32,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Terdapat ',
                        style: TextStyle(fontSize: 13, color: Colors.black87),
                      ),
                      const Text(
                        '180',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                      const Text(
                        ' Dokter Spesialis Di Aplikasi ini',
                        style: TextStyle(fontSize: 13, color: Colors.black87),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingWidget: Image.asset(
          'assets/floatingicons.png',
          height: 120,
        ),
        floatingWidgetHeight: 120,
        floatingWidgetWidth: 120,
      ),
    );
  }
}
