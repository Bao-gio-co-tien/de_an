import 'package:de_an/account_pages/user_header.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/theme.dart';
import '../models/user_model.dart';
import '../repository/user_repository.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final _formKey = GlobalKey<FormState>();
  final _userRepo = Get.find<UserRepository>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _userNameController;
  bool _isEditing = false;
  bool _isLoading = true;
  UserModel? _currentUser;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _userNameController = TextEditingController();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userData = await _userRepo.getUserDetails(user.uid);
        setState(() {
          _currentUser = userData;
          _nameController.text = userData.fullName;
          _emailController.text = userData.email;
          _phoneController.text = userData.phoneNo;
          _userNameController.text = userData.userName;
          _isLoading = false;
        });
      }
    } catch (e) {
      Get.snackbar(
        "Lỗi",
        "Không thể tải thông tin người dùng",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _userNameController.dispose();
    super.dispose();
  }

  Future<void> _handleDeleteAccount() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xóa tài khoản'),
        content: const Text('Bạn có chắc chắn muốn xóa tài khoản? Hành động này không thể hoàn tác.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Xóa'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await _userRepo.deleteUser();
        Get.offAllNamed('/login');
      } catch (e) {
        Get.snackbar(
          "Lỗi",
          "Không thể xóa tài khoản",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.1),
          colorText: Colors.red,
        );
      }
    }
  }

  Future<void> _saveChanges() async {
    if (_formKey.currentState!.validate()) {
      try {
        final updatedUser = UserModel(
          uid: _currentUser?.uid,
          fullName: _nameController.text,
          email: _emailController.text,
          password: _currentUser!.password,
          userName: _userNameController.text,
          phoneNo: _phoneController.text,
        );

        await _userRepo.updateUser(updatedUser);
        setState(() => _isEditing = false);
        Get.snackbar(
          "Thành công",
          "Thông tin đã được cập nhật",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.1),
          colorText: Colors.green,
        );
      } catch (e) {
        Get.snackbar(
          "Lỗi",
          "Không thể cập nhật thông tin",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.1),
          colorText: Colors.red,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryBackgroundColor,
        actions: [
          if (!_isEditing)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => setState(() => _isEditing = true),
            )
          else
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: _saveChanges,
            ),
        ],
      ),
      backgroundColor: AppTheme.primaryBackgroundColor,
      body: Form(
        key: _formKey,
        child: ListView(
          padding: AppTheme.allPadding,
          children: [
            const UserHeader(),
            const Divider(),
            _buildInfoTile(
              icon: Icons.person_sharp,
              title: 'Họ và tên',
              controller: _nameController,
              validator: (value) {
                if (value?.isEmpty ?? true) return 'Vui lòng nhập họ tên';
                return null;
              },
            ),
            _buildInfoTile(
              icon: Icons.person_outline,
              title: 'Tên người dùng',
              controller: _userNameController,
              validator: (value) {
                if (value?.isEmpty ?? true) return 'Vui lòng nhập tên người dùng';
                return null;
              },
            ),
            _buildInfoTile(
              icon: Icons.email,
              title: 'Email',
              controller: _emailController,
              enabled: false,
              validator: (value) {
                if (value?.isEmpty ?? true) return 'Vui lòng nhập email';
                if (!value!.contains('@')) return 'Email không hợp lệ';
                return null;
              },
            ),
            _buildInfoTile(
              icon: Icons.phone,
              title: 'Số điện thoại',
              controller: _phoneController,
              validator: (value) {
                if (value?.isEmpty ?? true) return 'Vui lòng nhập số điện thoại';
                if (value!.length < 10) return 'Số điện thoại không hợp lệ';
                return null;
              },
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _handleDeleteAccount,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(244, 208, 111, 1.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 15,
                  ),
                ),
                child: Text('Xóa tài khoản', style: AppTheme.heading3),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required TextEditingController controller,
    required String? Function(String?) validator,
    bool enabled = true,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title, style: AppTheme.heading4),
      trailing: _isEditing
          ? SizedBox(
            width: 200,
            child: TextFormField(
              controller: controller,
              validator: validator,
              enabled: enabled && _isEditing,
              decoration: const InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 8,
                ),
              ),
            ),
          )
          : Text(controller.text),
    );
  }
}