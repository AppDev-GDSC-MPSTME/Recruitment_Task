import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: DayYearInput(),
        ),
      ),
    );
  }
}

class DayYearInput extends StatefulWidget {
  @override
  _DayYearInputState createState() => _DayYearInputState();
}

class _DayYearInputState extends State<DayYearInput> {
  final TextEditingController _dayController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  String _result = '';

  void _checkDay() {
    final int? day = int.tryParse(_dayController.text);
    final int? year = int.tryParse(_yearController.text);

    if (day == null || year == null || day < 1 || day > 366) {
      setState(() {
        _result = 'Invalid input. Please enter a valid day and year.';
      });
      return;
    }

    final bool isLeapYear = (year % 4 == 0 && year % 100 != 0) || year % 400 == 0;

    if (!isLeapYear && day > 365) {
      setState(() {
        _result = 'Invalid day for non-leap year.';
      });
      return;
    }

    final DateTime date = DateTime(year, 1, 1).add(Duration(days: day - 1));
    final int weekOfYear = ((day - date.weekday + 10) / 7).floor();
    final String formattedDate = DateFormat('dd-MM-yyyy').format(date);

    setState(() {
      _result = 'Date: $formattedDate\nWeek of the year: $weekOfYear\nLeap Year: $isLeapYear';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Task Example: Check Day of the Year',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextField(
          controller: _dayController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(hintText: 'Day of the year'),
        ),
        TextField(
          controller: _yearController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(hintText: 'Year'),
        ),
        MaterialButton(
          onPressed: _checkDay,
          child: const Text("Check"),
        ),
        if (_result.isNotEmpty)
          Text(
            _result,
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
      ],
    );
  }
}
