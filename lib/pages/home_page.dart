
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/theme.dart';
import '../transaction_pages/categories_service.dart';
import '../transaction_pages/category.dart';
import '../transaction_pages/transactions.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CategoriesService _categoriesService = CategoriesService();
  final NumberFormat currencyFormatter = NumberFormat.currency(
    locale: 'vi_VN',
    symbol: 'đ',
    decimalDigits: 0,
  );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          color: AppTheme.primaryBackgroundColor,
          padding: AppTheme.secondPadding,
          child: StreamBuilder<List<Transactions>>(
            stream: _categoriesService.getTransactions(),
            builder: (context, transactionSnapshot) {
              if (transactionSnapshot.hasError) {
                return Center(child: Text('Lỗi: ${transactionSnapshot.error}'));
              }

              if (!transactionSnapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final transactions = transactionSnapshot.data!;

              double totalBalance = 0;
              double totalIncome = 0;
              double totalExpense = 0;

              for (var transaction in transactions) {
                if (transaction.type == 'Thu nhập') {
                  totalIncome += transaction.amount;
                } else {
                  totalExpense += transaction.amount.abs();
                }
                totalBalance = totalIncome - totalExpense;
              }

              return Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 5),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      formatDateTime(DateTime.now()),
                      style: AppTheme.heading2,
                    ),
                  ),
                  const Divider(),
                  SizedBox(height: 10),

                  Container(
                    width: double.maxFinite,
                    height: 100,
                    decoration: BoxDecoration(
                        color: AppTheme.secondaryBackgroundColor,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [BoxShadow(
                          blurRadius: 4,
                          color: Colors.black12,
                          offset: const Offset(0, 5),
                        ),]
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Số dư hiện tại',
                          style: AppTheme.heading3,
                        ),
                        Text(
                          currencyFormatter.format(totalBalance),
                          style: AppTheme.heading2.copyWith(
                              color: totalBalance >= 0 ? Colors.green.shade700 : Colors.red.shade700
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(child: Container(
                        height: 80,
                        padding: EdgeInsets.only(top: 12, left: 20, right: 20),
                        alignment: Alignment.topCenter,
                        decoration: BoxDecoration(
                            color: AppTheme.secondaryBackgroundColor,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [BoxShadow(
                              blurRadius: 4,
                              color: Colors.black12,
                              offset: const Offset(0, 5),
                            ),]
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Thu nhập',
                              style: TextStyle(
                                  fontFamily: AppTheme.fontFamily,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.green.shade700
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.arrow_circle_up, color: Colors.green.shade700),
                                Text(
                                  currencyFormatter.format(totalIncome),
                                  style: TextStyle(
                                      fontFamily: AppTheme.fontFamily,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.green.shade700
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )),

                      SizedBox(width: 20),

                      Expanded(child: Container(
                        height: 80,
                        padding: EdgeInsets.only(top: 12, left: 20, right: 20),
                        alignment: Alignment.topCenter,
                        decoration: BoxDecoration(
                            color: AppTheme.secondaryBackgroundColor,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [BoxShadow(
                              blurRadius: 4,
                              color: Colors.black12,
                              offset: const Offset(0, 5),
                            ),]
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Chi tiêu',
                              style: TextStyle(
                                  fontFamily: AppTheme.fontFamily,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.red.shade700
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.arrow_circle_down, color: Colors.red.shade700),
                                Text(
                                  currencyFormatter.format(totalExpense),
                                  style: TextStyle(
                                      fontFamily: AppTheme.fontFamily,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.red.shade700
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )),
                    ],
                  ),

                  SizedBox(height: 20),
                  Text('Giao dịch gần đây', style: AppTheme.heading3),
                  SizedBox(height: 10),

                  Expanded(
                    child: StreamBuilder<List<Category>>(
                      stream: _categoriesService.getCategories(),
                      builder: (context, categorySnapshot) {
                        if (!categorySnapshot.hasData) {
                          return const Center(child: CircularProgressIndicator());
                        }

                        final categories = categorySnapshot.data!;
                        final recentTransactions = transactions
                          ..sort((a, b) => b.date.compareTo(a.date))
                          ..take(5);

                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: recentTransactions.length,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final transaction = recentTransactions.elementAt(index);
                            final category = categories.firstWhere(
                                  (c) => c.id == transaction.categoryId,
                              orElse: () => Category(
                                  id: '',
                                  name: 'Không xác định',
                                  icon: 'help_outline',
                                  type: 'Chi tiêu'
                              ),
                            );

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 15.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppTheme.secondaryBackgroundColor,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Container(
                                                width: 50,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  color: AppTheme.primaryBackgroundColor,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              Icon(
                                                category.getIcon(),
                                                color: transaction.type == 'Thu nhập'
                                                    ? Colors.green.shade700
                                                    : Colors.red.shade700,
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: 12),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                category.name,
                                                style: AppTheme.heading4,
                                              ),
                                              if (transaction.note != null)
                                                Text(
                                                  transaction.note!,
                                                  style: AppTheme.heading6.copyWith(
                                                      color: Colors.grey
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            '${transaction.type == 'expense' ? '-' : '+'}${currencyFormatter.format(transaction.amount.abs())}',
                                            style: AppTheme.heading4.copyWith(
                                              color: transaction.type == 'Thu nhập'
                                                  ? Colors.green.shade700
                                                  : Colors.red.shade700,
                                            ),
                                          ),
                                          Text(
                                            _formatTransactionDate(transaction.date),
                                            style: AppTheme.heading6,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  String formatDateTime(DateTime dateTime) {
    return DateFormat.MMMMEEEEd('vi').format(dateTime);
  }

  String _formatTransactionDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Hôm nay';
    } else if (difference.inDays == 1) {
      return 'Hôm qua';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} ngày trước';
    } else {
      return DateFormat('dd/MM/yyyy').format(date);
    }
  }
}
