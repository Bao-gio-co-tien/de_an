
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'link_bank_account.dart';

class WalletCard extends StatelessWidget {
  final String walletType;
  final String title;
  final bool showLinkButton;

  WalletCard({required this.walletType, required this.title, required this.showLinkButton});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final CollectionReference transactions = FirebaseFirestore.instance.collection('transactions').doc(user?.uid).collection(walletType);

    return StreamBuilder<QuerySnapshot>(
      stream: transactions.snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        final data = snapshot.data?.docs ?? [];
        double balance = 0;

        for (var doc in data) {
          balance += doc['amount'];
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text('Số dư: VND ${balance.toStringAsFixed(2)}', style: TextStyle(fontSize: 16)),
                  if (showLinkButton)
                    Column(
                      children: [
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return LinkBankAccountDialog();
                              },
                            );
                          },
                          child: Text('Liên kết tài khoản ngân hàng'),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

