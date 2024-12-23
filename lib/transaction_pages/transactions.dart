import 'package:cloud_firestore/cloud_firestore.dart';

class Transactions {
  final String id;
  final double amount;
  final String categoryId;
  final DateTime date;
  final String? note;
  final String type;

  Transactions({
    required this.id,
    required this.amount,
    required this.categoryId,
    required this.date,
    this.note,
    required this.type,
  });

  factory Transactions.fromMap(String id, Map<String, dynamic> map) {
    return Transactions(
      id: id,
      amount: map['amount']?.toDouble() ?? 0.0,
      categoryId: map['categoryId'] ?? '',
      date: (map['date'] as Timestamp).toDate(),
      note: map['note'],
      type: map['type'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'categoryId': categoryId,
      'date': Timestamp.fromDate(date),
      'note': note,
      'type': type,
    };
  }
}