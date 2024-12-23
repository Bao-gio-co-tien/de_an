import 'package:cloud_firestore/cloud_firestore.dart';

class BankAccount {
  final String id;
  final String bankName;
  final String accountName;
  final String accountNumber;
  final double balance;
  final String userId;
  final String accessToken;
  final DateTime tokenExpiry;

  BankAccount({
    required this.id,
    required this.bankName,
    required this.accountName,
    required this.accountNumber,
    required this.balance,
    required this.userId,
    required this.accessToken,
    required this.tokenExpiry,
  });

  bool get isTokenValid =>
      DateTime.now().isBefore(tokenExpiry);

  factory BankAccount.fromMap(Map<String, dynamic> map, String id) {
    return BankAccount(
      id: id,
      bankName: map['bankName'] ?? '',
      accountName: map['accountName'] ?? '',
      accountNumber: map['accountNumber'] ?? '',
      balance: (map['balance'] ?? 0.0).toDouble(),
      userId: map['userId'] ?? '',
      accessToken: map['accessToken'] ?? '',
      tokenExpiry: (map['tokenExpiry'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bankName': bankName,
      'accountName': accountName,
      'accountNumber': accountNumber,
      'balance': balance,
      'userId': userId,
      'accessToken': accessToken,
      'tokenExpiry': Timestamp.fromDate(tokenExpiry),
    };
  }
}