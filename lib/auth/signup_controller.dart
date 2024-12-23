import 'package:de_an/models/user_model.dart';
import 'package:de_an/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../pages/sign_up/verify_email.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final email = TextEditingController();
  final fullName = TextEditingController();
  final userName = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();

  final userRepo = Get.put(UserRepository());
  final isLoading = false.obs;
  final isPasswordHidden = true.obs;

  @override
  void onClose() {
    email.dispose();
    fullName.dispose();
    userName.dispose();
    phoneNumber.dispose();
    password.dispose();
    super.onClose();
  }

  Future<void> createUser(UserModel user) async {
    try {
      isLoading.value = true;
      await userRepo.createUser(user);
      Get.to(() => const VerifyEmailPage());
    } catch (e) {
      print("Error in createUser: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }
}