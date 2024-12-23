import 'package:de_an/models/theme.dart';
import 'package:de_an/pages/forget_password_page.dart';
import 'package:de_an/pages/sign_up/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../auth/login_controller.dart';
import '../validation/validation.dart';


class LoginPage extends StatefulWidget {
  const LoginPage ({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final controller = Get.put(LoginController());

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
              Text('Đăng Nhập', style: AppTheme.heading1,),
              SizedBox(height: 90,),
              Form(key: _formKey, child: Column(
                  children: [
                    TextFormField(
                      controller: controller.email,
                      validator: (value) => Validator.validateEmail(value),
                      expands: false,
                      decoration: InputDecoration(
                          fillColor: AppTheme.primaryBackgroundColor,
                          filled: true,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                          labelText: 'Đăng nhập',
                          labelStyle: AppTheme.heading5,
                          prefixIcon: const Icon(Iconsax.user)
                      ),
                    ),
                    SizedBox(height: 20,),

                    Obx(() => TextFormField(
                      controller: controller.password,
                      validator: (value) => Validator.emtyValidateText('Mật khẩu', value),
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
                    Align(alignment: Alignment.centerRight,
                      child: TextButton(onPressed: () {Get.to(ForgetPasswordPage());}, child: const Text('Quên mật khẩu?')),
                    ),

                    SizedBox(height: 10,),
                    SizedBox(
                      width: double.infinity,
                      child: Obx(() => ElevatedButton(
                        onPressed: controller.isLoading.value
                            ? null
                            : () async {
                          if (_formKey.currentState!.validate()) {
                            await controller.loginUser();
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
                            : Text('Đăng Nhập', style: AppTheme.heading2),
                      )),
                    ),

                    TextButton(style: TextButton.styleFrom(
                      foregroundBuilder:
                          (BuildContext context, Set<WidgetState> states, Widget? child) {
                        return DecoratedBox(
                          decoration: BoxDecoration(
                            border: states.contains(WidgetState.hovered)
                                ? Border(bottom: BorderSide(color: Color.fromRGBO(
                                255, 136, 17, 1.0)))
                                : const Border(),
                          ),
                          child: child,
                        );
                      },
                    ),
                        onPressed: () => Get.to(SignUpPage()),
                        child: const Text('Chưa có tài khoản')
                    )
                  ],
              ),),
            ],
          ),
        ),
      ),
    );
  }
}