import 'package:de_an/account_pages/account_page.dart';
import 'package:de_an/pages/home_page.dart';
import 'package:de_an/report_pages/report_menu_page.dart';
import 'package:de_an/wallet_pages/wallet_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../transaction_pages/transaction_page.dart';


class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
        
          selectedIndex: controller.selectedIndex.value,
        
          onDestinationSelected: (index) => controller.selectedIndex.value = index,
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home_rounded), label: ''),
            NavigationDestination(icon: Icon(Icons.account_balance_wallet), label: ''),
            NavigationDestination(icon: Icon(Icons.insert_chart), label: ''),
            NavigationDestination(icon: Icon(Icons.person), label: ''),
          ],
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          backgroundColor: Color(0xFFEEDECC),
        ),
      ),
      body: Obx(() => controller.screen[controller.selectedIndex.value]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TransactionPage()),
          );
        },
        elevation: 5.0,
        backgroundColor: Color(0xFFFF8811),
        child: const Icon(
          Icons.add,
          size: 32,
        ),
      ),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screen = [const HomePage(), WalletPage(), ReportPage(), AccountPage()];
}