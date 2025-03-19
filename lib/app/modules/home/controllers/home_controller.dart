import 'dart:typed_data';
import 'package:excel/excel.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var newsList = <Map<String, String>>[].obs;

  @override
  void onInit() {
    _auth.authStateChanges().listen((User? user) {
      if (user != null && !user.isAnonymous) {
        Get.offNamed('/home');
      } else if (user != null && user.isAnonymous) {
        Get.offNamed('/home');
        Future.delayed(Duration(minutes: 30), () async {
          await FirebaseAuth.instance.signOut();
          Get.offAllNamed('/login');
          Get.snackbar("Info", "Sesi Anda Berakhir.");
        });
      }
    });
    loadExcelData();
    super.onInit();
  }

  Future<void> loadExcelData() async {
    try {
      ByteData data = await rootBundle
          .load('assets/news_kesehatan_balikpapan_real_images.xlsx');
      var bytes = data.buffer.asUint8List();
      var excel = Excel.decodeBytes(bytes);

      List<Map<String, String>> extractedNews = [];
      for (var table in excel.tables.keys) {
        var rows = excel.tables[table]!.rows;
        if (rows.isNotEmpty) {
          for (int i = 1; i < rows.length; i++) {
            extractedNews.add({
              "title": rows[i][0]?.value.toString() ?? "No Title",
              "date": rows[i][1]?.value.toString() ?? "No Date",
              "publisher": rows[i][2]?.value.toString() ?? "No Publisher",
              "description": rows[i][3]?.value.toString() ?? "No Description",
              "image": rows[i][4]?.value.toString() ?? "",
            });
          }
        }
      }
      newsList.value = extractedNews;
    } catch (e) {
      print("Error loading Excel data: $e");
    }
  }

  void logout() async {
    await _auth.signOut();
    Get.offNamed('/login');
  }
}
