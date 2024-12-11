// mahdi abdallah 12133605
import 'package:flutter/material.dart';

void main() {
  runApp(RunwayApp());
}

class RunwayApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RunwayCalculator(),
    );
  }
}

class RunwayCalculator extends StatefulWidget {
  @override
  _RunwayCalculatorState createState() => _RunwayCalculatorState();
}

class _RunwayCalculatorState extends State<RunwayCalculator> {
  final TextEditingController _speedController = TextEditingController();
  final TextEditingController _accelerationController = TextEditingController();
  bool _showResult = false;
  double? _runwayLength;

  void _calculateRunwayLength() {
    final double speed = double.tryParse(_speedController.text) ?? 0;
    final double acceleration = double.tryParse(_accelerationController.text) ?? 0;

    if (speed > 0 && acceleration > 0) {
      setState(() {
        _runwayLength = (speed * speed) / (2 * acceleration);
      });
    } else {
      setState(() {
        _runwayLength = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Runway Length Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _speedController,
              decoration: InputDecoration(labelText: 'Enter speed (m/s)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _accelerationController,
              decoration: InputDecoration(labelText: 'Enter acceleration (m/s²)'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  value: _showResult,
                  onChanged: (value) {
                    setState(() {
                      _showResult = value ?? false;
                    });
                  },
                ),
                Text('Show result'),
              ],
            ),
            ElevatedButton(
              onPressed: _calculateRunwayLength,
              child: Text('Calculate Minimum Runway Length'),
            ),
            SizedBox(height: 16),
            if (_showResult && _runwayLength != null)
              Text(
                'Minimum Runway Length: ${_runwayLength!.toStringAsFixed(2)} meters',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}
