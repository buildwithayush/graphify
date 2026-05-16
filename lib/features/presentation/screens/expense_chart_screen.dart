import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ExpenseChartScreen extends StatefulWidget {
  const ExpenseChartScreen({super.key});

  @override
  State<ExpenseChartScreen> createState() => _ExpenseChartScreenState();
}

class _ExpenseChartScreenState extends State<ExpenseChartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Charts Screen'),
        backgroundColor: Colors.lightGreen,
      ),
      body: Card(
        child: BarChart(
          BarChartData(
            barGroups: _barChartGroupData(),
            backgroundColor: Colors.white,
            borderData: _flBorderData(),
            gridData: _flGridData(),
          ),
        ),
      ),
    );
  }
}

FlBorderData _flBorderData() {
  return FlBorderData(
    show: true,
    border: Border(top: BorderSide(color: Colors.black, width: 3)),
  );
}

FlGridData _flGridData() {
  return FlGridData(
    drawHorizontalLine: true,
    show: true,
    horizontalInterval: 10,
    verticalInterval: 10,
    drawVerticalLine: false,
    checkToShowHorizontalLine: (value) => false,
  );
}

List<BarChartGroupData> _barChartGroupData() {
  return [
    BarChartGroupData(
      x: 1,
      barRods: [BarChartRodData(toY: 8, color: Colors.red)],
    ),
    BarChartGroupData(
      x: 2,
      barRods: [BarChartRodData(toY: 12, color: Colors.green)],
    ),
    BarChartGroupData(
      x: 3,
      barRods: [BarChartRodData(toY: 5, color: Colors.blue)],
    ),
    BarChartGroupData(
      x: 4,
      barRods: [BarChartRodData(toY: 15, color: Colors.orange)],
    ),
  ];
}
