import 'package:flutter/material.dart';

class ShortMonthValidator extends StatelessWidget {
  final DateTime selectedDate;
  final bool value;
  const ShortMonthValidator({
    super.key,
    required this.value,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color activeColor = theme.brightness == Brightness.dark
        ? Colors.white
        : Colors.blueGrey;

    return Padding(
      padding: const EdgeInsets.only(top: 6.0, left: 4.0),

      child: Row(
        children: [
          if (value && selectedDate.day > 28)
          Icon(Icons.info_outline_rounded, size: 13, color: activeColor),
          const SizedBox(width: 6),
          if (value && selectedDate.day > 28)
            const Expanded(
              child: Text(
                "Auto-logs on the 28th in shorter months",
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
