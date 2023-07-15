import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ledbim_assessment/controllers/home_controller.dart';
import 'package:ledbim_assessment/Screens/home_screen.dart';
import 'package:ledbim_assessment/Screens/todo_list.dart';


class BottomNavigationMain extends StatelessWidget {
  final BottomNavigationBarController homeController = Get.put(BottomNavigationBarController());

   BottomNavigationMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
            () => IndexedStack(
          index: homeController.currentIndex.value,
          children: [
            HomeScreen(),
            TodoListScreen(),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
            () => BottomNavigationBar(
          currentIndex: homeController.currentIndex.value,
          onTap: homeController.changePage,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );

  }
}