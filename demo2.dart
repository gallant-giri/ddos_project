import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: CounterApp(),
  ));
}

class CounterApp extends StatefulWidget {
  @override
  State<CounterApp> createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  int counter = 0;
  List<int> logs = [];

  void increment() {
    setState(() {
      counter++;
      logs.add(counter);
    });
  }

  void decrement() {
    if (counter > 0) {
      setState(() {
        counter--;
        logs.add(counter);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Simple Counter')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Current Value: $counter'),
            SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton(onPressed: decrement, child: Text('-')),
                SizedBox(width: 10),
                ElevatedButton(onPressed: increment, child: Text('+')),
              ],
            ),
            SizedBox(height: 20),
            Text('Value Logs:'),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: logs.length,
                itemBuilder: (context, index) {
                  return Text('Value ${index + 1}: ${logs[index]}');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
