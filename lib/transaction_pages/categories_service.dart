import 'package:cloud_firestore/cloud_firestore.dart';
import 'transactions.dart';
import 'category.dart';


class CategoriesService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Category>> getCategories() {
    return _firestore
        .collection('categories')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => Category.fromMap(doc.id, doc.data()))
        .toList());
  }

  Future<void> addCategory(Category category) async {
    await _firestore.collection('categories').add(category.toMap());
  }

  Future<void> addTransaction(Transactions transaction) async {
    await _firestore.collection('transactions').add(transaction.toMap());
  }

  Stream<List<Transactions>> getTransactions() {
    return _firestore
        .collection('transactions')
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => Transactions.fromMap(doc.id, doc.data()))
        .toList());
  }
}