import 'package:de_an/models/theme.dart';
import 'package:de_an/wallet_pages/wallet_card.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  final User? currentUser = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ví giao dịch', style: AppTheme.heading2,),
        backgroundColor: AppTheme.primaryBackgroundColor,
      ),
      backgroundColor: AppTheme.primaryBackgroundColor,
      body: Column(
        children: <Widget>[
          WalletCard(walletType: 'bank', title: 'Số dư tài khoản ngân hàng', showLinkButton: true),
          WalletCard(walletType: 'manual', title: 'Số dư tiền mặt', showLinkButton: false),
        ],
      ),
    );
  }
}

