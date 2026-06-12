import 'package:flutter/material.dart';

class BudgetProgressBar extends StatelessWidget {
  final double monthlyExpense;
  final double monthlyBudget;
  const BudgetProgressBar({
    super.key,
    required this.monthlyExpense,
    required this.monthlyBudget,
  });

  Color _getBarColor(double percentage) {
    if (percentage <= 0.50) {
      return const Color(0xFF4ADE80);
    } else if (percentage <= 0.70) {
      return const Color(0xFFFBBF24);
    } else if (percentage <= 0.80) {
      return const Color(0xFFF87171);
    } else if (percentage <= 1.00) {
      return const Color(0xFFEF4444);
    } else {
      return const Color(0xFF991B1B);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (monthlyBudget <= 0) return const SizedBox.shrink();

    final double percentage = monthlyExpense / monthlyBudget;

    final double clampedPercentage = percentage.clamp(0.0, 1.0);

    final double remainingBudget = monthlyBudget - monthlyExpense;

    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,bottom: 6),
      child: Column(
        children: [
          Container(
            height: 12,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFF334155),
              borderRadius: BorderRadius.circular(6),
            ),
            child: LayoutBuilder(
              builder: (context, constrains) {
                final maxWidth = constrains.maxWidth;
                final filledWidth = maxWidth * clampedPercentage;
      
                return Row(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(microseconds: 400),
                      width: filledWidth,
                      height: 12,
                      decoration: BoxDecoration(
                        color: _getBarColor(percentage),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height:15),
      
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Spent: ${(percentage * 100).toStringAsFixed(0)}%',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF94A3B8),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                remainingBudget >= 0
                    ? '₹${remainingBudget.toStringAsFixed(0)} Left'
                    : '₹${remainingBudget.abs().toStringAsFixed(0)} Over Budget',
                style: TextStyle(
                  fontSize: 12,
                  color: remainingBudget >= 0
                      ? const Color(0xFF94A3B8)
                      : const Color(0xFFF87171),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
