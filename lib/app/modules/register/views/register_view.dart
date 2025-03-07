import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/register_controller.dart'; // Pastikan path ini sama dengan di binding

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => controller.username.value = value,
              decoration: InputDecoration(labelText: "Username"),
            ),
            TextField(
              onChanged: (value) => controller.email.value = value,
              decoration: InputDecoration(labelText: "Email"),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              obscureText: true,
              onChanged: (value) => controller.password.value = value,
              decoration: InputDecoration(labelText: "Password"),
            ),
            TextField(
              obscureText: true,
              onChanged: (value) => controller.confirmPassword.value = value,
              decoration: InputDecoration(labelText: "Ulangi Password"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: controller.register,
              child: Text("Daftar"),
            ),
          ],
        ),
      ),
    );
  }
}
