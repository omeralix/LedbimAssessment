import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ledbim_assessment/controllers/auth_controller.dart';
import 'package:ledbim_assessment/controllers/auth_provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final AuthController authController = Get.find();
  logout() {
    authController.logout();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Get.put(AuthProvider());
    return Scaffold(
      appBar: AppBar(
        title: Text("LedBim assessment User list"),
        leading: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).colorScheme.error)),
          onPressed: () {
            logout();
          },
          child: Text("Logout"),
        ),
      ),
      body: Obx(() {
        if (authProvider.users.isEmpty) {
          return Center(
            child: Text(authProvider.getUsers().toString()),
          );
        } else {
          return ListView.builder(
              itemCount: authProvider.users.length,
              itemBuilder: (context, index) {
                final user = authProvider.users[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(user.avatar),
                  ),
                  title: Text(user.firstName),
                  subtitle: Text(user.lastName),
                  trailing: Text(user.email),
                );
              });
        }
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () {
          authProvider.getUsers();
        },
      ),
    );
  }
}