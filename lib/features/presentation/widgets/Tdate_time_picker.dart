import 'package:flutter/material.dart';

class TdateTimePicker extends StatefulWidget {
  final Function(DateTime) onDateSelected;
  final String buttonText;

  const TdateTimePicker({
    super.key,
    required this.onDateSelected,
    this.buttonText = "Pick a Date",
  });

  @override
  _TdateTimePickerState createState() => _TdateTimePickerState();
}

class _TdateTimePickerState extends State<TdateTimePicker> {
  DateTime? _chosenDate;

  void _showCalendar() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _chosenDate = picked;
      });

      widget.onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
  return SizedBox(
  width: double.infinity,
  child: ElevatedButton.icon(
    onPressed: _showCalendar,
    icon: const Icon(Icons.calendar_today_outlined, size: 20),
    label: Text(
      _chosenDate == null
          ? widget.buttonText
          : "${_chosenDate!.day}/${_chosenDate!.month}/${_chosenDate!.year}",
      overflow: TextOverflow.ellipsis,
    ),
    style: ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black87,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Colors.grey.shade300,
        ),
      ),
      alignment: Alignment.centerLeft,
    ),
  ),
);
  }
}
