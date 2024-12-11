//mahdi abdallah 12133605
import 'package:flutter/material.dart';

void main() {
  runApp(RunwayCalculatorApp());
}

class RunwayCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
  double? _runwayLength;
  bool _showLength = false;

  void _calculateRunwayLength() {
    final double? speed = double.tryParse(_speedController.text);
    final double? acceleration = double.tryParse(_accelerationController.text);

    if (speed != null && acceleration != null && acceleration > 0) {
      setState(() {
        _runwayLength = (speed * speed) / (2 * acceleration);
      });
    } else {
      setState(() {
        _runwayLength = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter valid speed and acceleration values!')),
      );
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
          children: [
            TextField(
              controller: _speedController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Speed (v) in m/s',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _accelerationController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Acceleration (a) in m/s²',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _calculateRunwayLength,
                  child: Text('Calculate'),
                ),
                SizedBox(width: 16),
                Checkbox(
                  value: _showLength,
                  onChanged: (bool? value) {
                    setState(() {
                      _showLength = value ?? false;
                    });
                  },
                ),
                Text('Show result '),
              ],
            ),
            if (_showLength && _runwayLength != null)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  'Runway Length: ${_runwayLength!.toStringAsFixed(2)} meters',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
