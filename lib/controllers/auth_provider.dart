import 'dart:convert';
import 'package:get/get.dart';


import 'package:http/http.dart' as http;
import 'package:ledbim_assessment/models/user_model.dart';
class AuthProvider extends GetxController{
  final users = <AuthUser>[].obs;
  Future<void> getUsers() async {
    final response = await http.get(Uri.parse('https://reqres.in/api/users'));

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final List<dynamic> usersJson = responseBody['data'];

      final List<AuthUser> usersFromJson = usersJson.map((json) => AuthUser.fromJson(json)).toList();
      final List<AuthUser> newUsers = usersFromJson.where((user) => !users.any((existingUser) => existingUser.id == user.id)).toList();
      users.addAll(newUsers);
    } else {
      throw Exception('Failed to load users');
    }
  }
}