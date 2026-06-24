import 'package:flutter/material.dart';

class RecurringTickBox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final DateTime selectedDate;

  const RecurringTickBox({
    super.key,
    required this.value,
    required this.onChanged,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    
   
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        // TOOLTIP ENGINE
        Tooltip(
          message: "Make Recurring 🔄",
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: const TextStyle(
            color: Colors.black,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          child: SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(
              value: value,
              onChanged: onChanged,
              activeColor: Colors.white,
              checkColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              side: BorderSide(
                color: value
                    ? Colors.white
                    : Colors.white.withValues(alpha: 0.8),
                width: value ? 2.5 : 2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
