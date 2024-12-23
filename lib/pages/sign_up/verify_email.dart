import 'package:de_an/models/theme.dart';
import 'package:de_an/pages/login_page.dart';
import 'package:de_an/pages/sign_up/success_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyEmailPage extends StatelessWidget {
  const VerifyEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppTheme.primaryBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryBackgroundColor,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: () => Get.offAll(() => LoginPage()), icon: Icon(Icons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppTheme.allPadding,
          child: Column(
            children: [
              Image.asset('assets/verify_email.png', width: size.width * 0.6,),
              const SizedBox(height: 32,),
              
              Text('Xác nhận Email của bạn.', style: AppTheme.heading2,),
              const SizedBox(height: 20,),

              Text('example@gmail.com', style: AppTheme.heading4, textAlign: TextAlign.center,),
              const SizedBox(height: 20,),

              Text('Chúc mừng bạn đã tạo tài khoản thành công!', style: AppTheme.heading6,),
              Text('Hãy thực hiện bước xác nhận email để sử dụng ứng dụng!', style: AppTheme.heading6,),
              const SizedBox(height: 32,),

              SizedBox(width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.to(() => SuccessPage(
                    image: 'assets/success_verify.jpg',
                    title: 'Xác nhận Email thành công!',
                    subTitle: 'Vậy là bạn đã xác nhận email thành công, hãy đăng nhập để vào giao diện ứng dụng',
                    onPressed: () => Get.to(() => const LoginPage()),
                  )),

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(157, 217, 210, 1.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 120, vertical: 15),
                  ),
                  child: Text('Tiếp tục',
                    style: AppTheme.heading3,
                  ),
                ),
              ),
              SizedBox(height: 20,),
              TextButton(onPressed: () {}, child: Text('Gửi lại email xác nhận', style: AppTheme.heading4,)),
            ],
          ),
        ),
      ),
    );
  }
}