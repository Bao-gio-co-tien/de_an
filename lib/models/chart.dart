import 'package:de_an/models/theme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../transaction_pages/transactions.dart';

class MyChart extends StatefulWidget {
  final List<Transactions> transactions;
  final int viewIndex;

  const MyChart({
    super.key,
    required this.transactions,
    this.viewIndex = 1,
  });

  @override
  State<MyChart> createState() => _MyChartState();
}

class _MyChartState extends State<MyChart> {
  @override
  Widget build(BuildContext context) {
    return BarChart(mainBarData());
  }

  List<BarChartGroupData> showingGroups() {
    final DateTime now = DateTime.now();
    final Map<int, double> groupedExpenses = {};
    final Map<int, double> groupedIncomes = {};

    for (var transaction in widget.transactions) {
      int groupKey;
      switch (widget.viewIndex) {
        case 0:
          groupKey = now.difference(transaction.date).inDays;
          break;
        case 1:
          groupKey = (now.difference(transaction.date).inDays / 7).floor();
          break;
        case 2:
          groupKey = (now.year - transaction.date.year) * 6 +
              (now.month - transaction.date.month);
          break;
        default:
          groupKey = -1;
      }

      if (groupKey >= 0 && groupKey < 8) {
        if (transaction.type == 'Chi tiêu') {
          groupedExpenses[groupKey] =
              (groupedExpenses[groupKey] ?? 0) + transaction.amount.abs();
        } else if (transaction.type == 'Thu nhập') {
          groupedIncomes[groupKey] =
              (groupedIncomes[groupKey] ?? 0) + transaction.amount.abs();
        }
      }
    }

    return List.generate(7, (i) {
      double expenseAmount = groupedExpenses[i] ?? 0;
      double incomeAmount = groupedIncomes[i] ?? 0;
      return BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: expenseAmount / 1000,
            color: Colors.red.shade300,
            width: 15,
          ),
          BarChartRodData(
            toY: incomeAmount / 1000,
            color: Colors.green.shade300,
            width: 15,
          ),
        ],
      );
    }).toList().reversed.toList();
  }

  BarChartData mainBarData() {
    return BarChartData(
      titlesData: FlTitlesData(
        leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      barGroups: showingGroups(),
      gridData: const FlGridData(show: false),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    final now = DateTime.now();
    String label;

    switch (widget.viewIndex) {
      case 0:
        label = DateFormat('dd/MM').format(
            now.subtract(Duration(days: value.toInt()))
        );
        break;
      case 1:
        label = DateFormat('dd/MM').format(
            now.subtract(Duration(days: (value.toInt() * 7)))
        );
        break;
      case 2:
        label = DateFormat('MM/YY').format(
            now.subtract(Duration(days: (value.toInt() * 30)))
        );
        break;
      default:
        label = '';
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: Text(label, style: AppTheme.heading6),
    );
  }
}