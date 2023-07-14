import 'package:flutter/material.dart';

void main() => runApp(BMICalculatorApp());

class BMICalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BMICalculator(),
    );
  }
}

class BMICalculator extends StatefulWidget {
  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  final _heightTextController = TextEditingController();
  final _weightTextController = TextEditingController();
  double _height = 170.0;
  double _weight = 70.0;
  double _bmi = 0.0;

  @override
  void dispose() {
    _heightTextController.dispose();
    _weightTextController.dispose();
    super.dispose();
  }

  void _calculateBMI() {
    // Hide the keyboard
    FocusScope.of(context).unfocus();

    setState(() {
      _height = double.parse(_heightTextController.text);
      _weight = double.parse(_weightTextController.text);
      _bmi = _weight / ((_height / 100) * (_height / 100));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              controller: _heightTextController,
              decoration: const InputDecoration(
                labelText: 'Height (cm)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              controller: _weightTextController,
              decoration: const InputDecoration(
                labelText: 'Weight (kg)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: _calculateBMI,
            child: const Text('Calculate BMI'),
          ),
          const SizedBox(height: 16.0),
          Text(
            'Your BMI: ${_bmi.toStringAsFixed(1)}',
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
