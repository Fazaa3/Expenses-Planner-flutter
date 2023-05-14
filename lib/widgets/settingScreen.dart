import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double _maxExpenses = 0.0;

 void _saveSettings() async {
  
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setDouble('maxExpenses', _maxExpenses);
 // print('Maximum expenses set to: $_maxExpenses');
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Set Maximum Expenses',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(labelText: 'Maximum Expenses'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _maxExpenses = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _saveSettings();
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}