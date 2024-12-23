import 'package:de_an/account_pages/user_header.dart';
import 'package:de_an/models/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../repository/user_repository.dart';
import 'account_user_detail_page.dart';

class AccountPage extends StatelessWidget {
  final userRepo = Get.put(UserRepository());
  AccountPage({super.key});

  Future<void> _handleSignOut(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Đăng xuất'),
        content: const Text('Bạn có chắc chắn muốn đăng xuất?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Đăng xuất'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await FirebaseAuth.instance.signOut();
        Get.offAllNamed('/login');
      } catch (e) {
        Get.snackbar(
          "Lỗi",
          "Có lỗi xảy ra khi đăng xuất",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.1),
          colorText: Colors.red,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryBackgroundColor,
      body: ListView(
        padding: AppTheme.allPadding,
        children: [
          const UserHeader(),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Thông tin tài khoản'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Get.to(() => const DetailPage()),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Đăng xuất'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _handleSignOut(context),
          ),
        ],
      ),
    );
  }
}