import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LinkBankAccountDialog extends StatelessWidget {
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();

  LinkBankAccountDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Liên kết tài khoản ngân hàng'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: bankNameController,
            decoration: InputDecoration(labelText: 'Tên ngân hàng'),
          ),
          TextField(
            controller: accountNumberController,
            decoration: InputDecoration(labelText: 'Số tài khoản'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Hủy'),
        ),
        ElevatedButton(
          onPressed: () async {
            final User? user = FirebaseAuth.instance.currentUser;
            final CollectionReference bankAccounts = FirebaseFirestore.instance.collection('bankAccounts').doc(user?.uid).collection('accounts');

            await bankAccounts.add({
              'bankName': bankNameController.text,
              'accountNumber': accountNumberController.text,
            });

            Navigator.of(context).pop();
          },
          child: Text('Liên kết'),
        ),
      ],
    );
  }
}
