import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledbim_assessment/controllers/auth_controller.dart';
import 'package:ledbim_assessment/helpers/exceptions.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final AuthController authController = Get.find();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
   final RxString  errorMessage = "".obs;
  LoginScreen({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: GetBuilder<AuthController>(
        init: authController,
        builder: (controller) {
          return Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  validator: (value) {
                    if (value != null &&value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: () async {
                    if(_formKey.currentState!.validate()){
                     try{
                      await authController.login(emailController.text, passwordController.text);
                    }on WrongCredentialsException catch(_){
                       errorMessage.value = "Wrong Credentials";
                     }on GenericAuthException catch(_){
                       errorMessage.value = "Generic Auth exceptions";
                     }catch(_){
                       errorMessage.value = "Something went wrong";
                     }
                    }

                  },
                  child: const Text('Login'),
                ),
                const SizedBox(height: 10 ),
                Obx(() => Text(errorMessage.value,style: const TextStyle(color: Colors.red,fontSize: 18),)),
              ],
            ),
          );
        },
      ),
    );
  }
}
