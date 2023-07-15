import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledbim_assessment/controllers/auth_controller.dart';
import 'package:ledbim_assessment/Screens/bottom_navigation_main.dart';
import 'package:ledbim_assessment/Screens/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Persistent Login',
      theme: ThemeData(colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(error: Colors.red),
      ),
      home: Obx(
            () => authController.isLoggedIn.value
            ? BottomNavigationMain()
            :  LoginScreen(),
      ),
    );
  }
}

