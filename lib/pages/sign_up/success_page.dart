import 'package:de_an/models/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../login_page.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key, required this.image, required this.title, required this.subTitle, required this.onPressed});

  final String image, title, subTitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppTheme.secondaryBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: AppTheme.allPadding,
          child: Column(
            children: [
              Image.asset(image, width: size.width * 0.6,),
              const SizedBox(height: 32.0,),

              Text(title, style: AppTheme.heading2,),
              const SizedBox(height: 20,),

              Text(subTitle, style: AppTheme.heading6,),
              const SizedBox(height: 32,),

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
                  child: Text('Tiếp tục',
                    style: AppTheme.heading2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
