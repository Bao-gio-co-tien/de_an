import 'package:de_an/auth/signup_controller.dart';
import 'package:de_an/validation/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../models/theme.dart';
import '../../models/user_model.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(backgroundColor: AppTheme.secondaryBackgroundColor,),
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          padding: AppTheme.secondPadding,
          color: AppTheme.secondaryBackgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Đăng Ký', style: AppTheme.heading1,),
              SizedBox(height: 90,),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: controller.fullName,
                        validator: (value) => Validator.emtyValidateText('Tên người dùng', value),
                        expands: false,
                        decoration: InputDecoration(
                            fillColor: AppTheme.primaryBackgroundColor,
                            filled: true,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                            labelText: 'Tên người dùng',
                            labelStyle: AppTheme.heading5,
                            prefixIcon: const Icon(Iconsax.user_edit)
                        ),
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                        controller: controller.userName,
                        validator: (value) => Validator.emtyValidateText('Tên đăng nhập', value),
                        expands: false,
                        decoration: InputDecoration(
                            fillColor: AppTheme.primaryBackgroundColor,
                            filled: true,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                            labelText: 'Tên đăng nhập',
                            labelStyle: AppTheme.heading5,
                            prefixIcon: const Icon(Iconsax.user_edit)
                        ),
                      ),

                      SizedBox(height: 20,),
                      TextFormField(
                        controller: controller.email,
                        validator: (value) => Validator.validateEmail(value),
                        expands: false,
                        decoration: InputDecoration(
                            fillColor: AppTheme.primaryBackgroundColor,
                            filled: true,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                            labelText: 'Email',
                            labelStyle: AppTheme.heading5,
                            prefixIcon: const Icon(Iconsax.direct)
                        ),
                      ),

                      SizedBox(height: 20,),
                      TextFormField(
                        controller: controller.phoneNumber,
                        validator: (value) => Validator.validatePhoneNumber(value),
                        expands: false,
                        decoration: InputDecoration(
                            fillColor: AppTheme.primaryBackgroundColor,
                            filled: true,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                            labelText: 'Số điện thoại',
                            labelStyle: AppTheme.heading5,
                            prefixIcon: const Icon(Iconsax.call)
                        ),
                      ),

                      SizedBox(height: 20,),
                      Obx(() => TextFormField(
                        controller: controller.password,
                        validator: (value) => Validator.validatePassword(value),
                        obscureText: controller.isPasswordHidden.value,
                        decoration: InputDecoration(
                          fillColor: AppTheme.primaryBackgroundColor,
                          filled: true,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                          labelText: 'Mật khẩu',
                          labelStyle: AppTheme.heading5,
                          prefixIcon: const Icon(Iconsax.password_check),
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller.isPasswordHidden.value = !controller.isPasswordHidden.value;
                            },
                            icon: Icon(
                              controller.isPasswordHidden.value ? Iconsax.eye_slash : Iconsax.eye,
                            ),
                          ),
                        ),
                      )),

                      SizedBox(height: 50,),
                    SizedBox(
                      width: double.infinity,
                      child: Obx(() => ElevatedButton(
                        onPressed: controller.isLoading.value
                            ? null
                            : () async {
                          if (_formKey.currentState!.validate()) {
                            final user = UserModel(
                              fullName: controller.fullName.text.trim(),
                              email: controller.email.text.trim(),
                              password: controller.password.text.trim(),
                              userName: controller.userName.text.trim(),
                              phoneNo: controller.phoneNumber.text.trim(),
                            );
                            await controller.createUser(user);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(157, 217, 210, 1.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        ),
                        child: controller.isLoading.value
                            ? const CircularProgressIndicator()
                            : Text('Đăng Ký', style: AppTheme.heading2),
                      )),
                    ),
                    ],
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

