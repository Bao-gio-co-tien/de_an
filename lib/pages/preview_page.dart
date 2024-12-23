import 'package:de_an/models/theme.dart';
import 'package:de_an/pages/sign_up/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login_page.dart';

class PreviewPage extends StatelessWidget {
  const PreviewPage({super.key});

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 208, 111, 1.0),
      body: SingleChildScrollView(
          child: Padding(
            padding: AppTheme.allPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/preview_page.png'),
                Text(
                  'Chào mừng bạn đến với ứng dụng quản lí chi tiêu Monney! Monney sẽ giúp bạn quản lí tài sản của bản thân tốt hơn.',
                  style: AppTheme.heading6,
                ),
                SizedBox(height: 20,),

                SizedBox(width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Get.to(() => LoginPage()),

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(157, 217, 210, 1.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    ),
                    child: Text('Đăng Nhập',
                      style: AppTheme.heading3,
                    ),
                  ),
                ),

                SizedBox(height: 15,),
                SizedBox(width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Get.to(() => SignUpPage()),

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(57, 47, 90, 1.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    ),
                    child: Text('Đăng Ký ',
                      style: AppTheme.heading3DiffColor,
                    ),
                  ),
                ),
              ],
            ),
          )
      )
    );
  }
}
