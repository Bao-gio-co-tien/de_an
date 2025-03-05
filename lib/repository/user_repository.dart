
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:de_an/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;


  Future<void> createUser(UserModel user) async {
    try {
      final UserCredential authResult = await _auth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      if (authResult.user != null) {
        final userDataWithId = {
          ...user.toJson(),
          'uid': authResult.user!.uid,
          'createdAt': Timestamp.now(),
        };

        await _db
            .collection("Users")
            .doc(authResult.user!.uid)
            .set(userDataWithId)
            .then((_) {
          Get.snackbar(
            "Thành công",
            "Tài khoản của bạn đã được tạo.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green.withOpacity(0.1),
            colorText: Colors.green,
          );
        });
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = "Có lỗi xảy ra. Hãy thử lại";

      switch (e.code) {
        case 'weak-password':
          errorMessage = "Mật khẩu quá yếu";
          break;
        case 'email-already-in-use':
          errorMessage = "Email đã được sử dụng";
          break;
        case 'invalid-email':
          errorMessage = "Email không hợp lệ";
          break;
      }

      Get.snackbar(
        "Lỗi",
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
      rethrow;
    } catch (e) {
      Get.snackbar(
        "Lỗi",
        "Có lỗi xảy ra. Hãy thử lại",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
      rethrow;
    }
  }

  Future<UserModel> getUserDetails(String uid) async {
    final doc = await _db.collection("Users").doc(uid).get();
    if (!doc.exists) {
      throw Exception("User not found");
    }
    return UserModel.fromJson(doc.data()!);
  }

  Future<void> updateUser(UserModel user) async {
    if (user.uid == null) throw Exception("User ID is required");

    final updates = {
      'fullName': user.fullName,
      'userName': user.userName,
      'phoneNo': user.phoneNo,
    };

    await _db.collection("Users").doc(user.uid).update(updates);
  }

  Future<void> deleteUser() async {
    final user = _auth.currentUser;
    if (user == null) throw Exception("No user logged in");

    await _db.collection("Users").doc(user.uid).delete();

    await user.delete();
  }
}
