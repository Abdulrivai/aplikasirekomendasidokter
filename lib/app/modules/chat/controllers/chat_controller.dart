import 'dart:convert';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ChatController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  RxList<ChatMessage> messages = <ChatMessage>[].obs;
  RxList<ChatUser> typingUsers = <ChatUser>[].obs;

  late ChatUser currentUser;
  final ChatUser chatbot = ChatUser(
    id: '123',
    firstName: 'Sidokter',
    profileImage:
        'https://firebasestorage.googleapis.com/v0/b/bank-sampah-1ef03.appspot.com/o/caridokter%2Fprofile%20chatbot.png?alt=media&token=7f7c2295-6c60-4191-9b17-c5a7f81c8230',
  );

  TextEditingController textController = TextEditingController();

  void onSend(ChatMessage newChat) {
    messages.insert(0, newChat);
    processMessage(newChat);
  }

  Future<void> processMessage(ChatMessage chatMessage) async {
    typingUsers.add(chatbot);
    final url =
        Uri.parse('https://balikpapan-sehat-production.up.railway.app/chat');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
            {'user_id': _auth.currentUser?.uid, 'message': chatMessage.text}),
      );

      final data = jsonDecode(response.body)['response'];
      messages.insert(
          0,
          ChatMessage(
            text: data,
            user: chatbot,
            createdAt: DateTime.now(),
          ));
    } catch (error) {
      messages.insert(
          0,
          ChatMessage(
            text: 'Maaf, Sepertinya ada kesalahan',
            user: chatbot,
            createdAt: DateTime.now(),
          ));
    } finally {
      typingUsers.remove(chatbot);
    }
  }

  @override
  void onInit() {
    super.onInit();
    _auth.authStateChanges().listen((User? user) {
      if (user != null && !user.isAnonymous) {
        Get.offNamed('/home');
      } else if (user != null && user.isAnonymous) {
        Get.offNamed('/chat');
        Future.delayed(Duration(minutes: 30), () async {
          await FirebaseAuth.instance.signOut();
          Get.offAllNamed('/login');
          Get.snackbar("Info", "Sesi Anda Berakhir.");
        });
      }
    });

    currentUser = ChatUser(
      id: _auth.currentUser?.uid ?? '',
      firstName: _auth.currentUser?.displayName ?? 'User',
      profileImage: _auth.currentUser?.photoURL ??
          'https://eduparx.id/blog/wp-content/uploads/2024/05/gemini_ai_google_1701928139717.webp',
    );
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}
