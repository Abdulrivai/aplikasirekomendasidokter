import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  // Initialize firebase user information
  final FirebaseAuth _auth = FirebaseAuth.instance;

  RxList<ChatMessage> messages = <ChatMessage>[].obs;

  late ChatUser currentUser;

  final ChatUser chatbot = ChatUser(
      id: '123',
      firstName: 'Chatbot',
      profileImage:
          'https://eduparx.id/blog/wp-content/uploads/2024/05/gemini_ai_google_1701928139717.webp');

  void onSend(ChatMessage newChat) {
    messages.insert(0, newChat);
  }

  @override
  void onInit() {
    _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        Get.offNamed('/login');
      }
    });

    currentUser = ChatUser(
        id: _auth.currentUser!.uid,
        firstName: _auth.currentUser!.displayName ?? 'User',
        profileImage: _auth.currentUser!.photoURL ??
            'https://eduparx.id/blog/wp-content/uploads/2024/05/gemini_ai_google_1701928139717.webp');
    super.onInit();
  }
}
