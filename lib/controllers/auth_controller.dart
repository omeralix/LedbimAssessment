import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ledbim_assessment/helpers/exceptions.dart';
class AuthController extends GetxController {
  final storage = const FlutterSecureStorage();
  final isLoggedIn = false.obs;



  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }
//check if there are any AuthToken
  Future<void> checkLoginStatus() async {
    final token = await storage.read(key: 'authToken');
    isLoggedIn.value = token != null;
  }
//http request to reqres.in
  Future<void> login(String email, String password) async {

      final response = await http.post(
        Uri.parse('https://reqres.in/api/login'),
        body: {
          'email': email,
          'password': password,
        },
      );
//Check the response
      switch (response.statusCode) {
        case 200:
          final responseBody = jsonDecode(response.body);
          final token = responseBody['token'];
          await storage.write(key: 'authToken', value: token);
          isLoggedIn.value = true;
          print('Data fetched successfully');
          break;
        case 400:
          throw WrongCredentialsException();

        case 401:
          throw EmailOrPassEmptyException();
        case 404:
          print(response.statusCode);
          throw GenericAuthException();
        case 500:
          print(response.statusCode);
          throw GenericAuthException();
        default:
          print(response.statusCode);
          throw GenericAuthException();
      }

  }

  Future<void> logout() async {
    await storage.delete(key: 'authToken');
    isLoggedIn.value = false;

    // Navigate to the login screen or perform any other actions
    // after logging out
    print('Logged out successfully');
  }

}