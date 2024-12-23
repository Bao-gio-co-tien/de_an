import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/nav_bar.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();

  final isLoading = false.obs;
  final isPasswordHidden = true.obs;

  final _auth = FirebaseAuth.instance;

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    super.onClose();
  }

  Future<void> loginUser() async {
    try {
      isLoading.value = true;
      await _auth.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      Get.snackbar(
        "Thành công",
        "Đăng nhập thành công",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green,
      );

      Get.offAll(() => NavBar());
    } on FirebaseAuthException catch (e) {
      String errorMessage = "Đăng nhập thất bại";

      switch (e.code) {
        case 'user-not-found':
          errorMessage = "Không tìm thấy tài khoản với email này";
          break;
        case 'wrong-password':
          errorMessage = "Sai mật khẩu";
          break;
        case 'invalid-email':
          errorMessage = "Email không hợp lệ";
          break;
        case 'user-disabled':
          errorMessage = "Tài khoản đã bị vô hiệu hóa";
          break;
      }

      Get.snackbar(
        "Lỗi",
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    } catch (e) {
      Get.snackbar(
        "Lỗi",
        "Có lỗi xảy ra. Vui lòng thử lại",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
