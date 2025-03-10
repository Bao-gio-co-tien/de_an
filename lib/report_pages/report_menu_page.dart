import 'package:flutter/material.dart';

import '../models/chart.dart';
import '../models/theme.dart';
import '../transaction_pages/categories_service.dart';
import '../transaction_pages/transactions.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final CategoriesService _categoriesService = CategoriesService();
  int _viewIndex = 1;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppTheme.primaryBackgroundColor,
      body: Padding(
        padding: AppTheme.allPadding,
        child: SingleChildScrollView(
          child: StreamBuilder<List<Transactions>>(
            stream: _categoriesService.getTransactions(),
            builder: (context, transactionSnapshot) {
              if (!transactionSnapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final transactions = transactionSnapshot.data!;
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildViewButton(0, 'Ngày', Icons.today),
                      const SizedBox(width: 10),
                      _buildViewButton(1, 'Tuần', Icons.calendar_view_week),
                      const SizedBox(width: 10),
                      _buildViewButton(2, 'Tháng', Icons.calendar_month),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: size.width,
                    height: size.height * 0.4,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: MyChart(
                          transactions: transactions,
                          viewIndex: _viewIndex
                      ),
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

  Widget _buildViewButton(int index, String label, IconData icon) {
    return Flexible(child: ElevatedButton(
      onPressed: () => setState(() => _viewIndex = index),
      style: ElevatedButton.styleFrom(
        backgroundColor: _viewIndex == index
            ? Color(0xFF9DD9D2)
            : Colors.grey.shade300,
      ),
      child: Row(
        children: [
          Icon(icon, size: 15 ,color: _viewIndex == index ? AppTheme.textColor : Colors.black),
          const SizedBox(width: 5),
          Text(label,
              style: TextStyle(
                  color: _viewIndex == index ? AppTheme.textColor : Colors.black
              )
          ),
        ],
      ),
    )
    );
  }
}