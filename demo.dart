import 'package:flutter/material.dart';

void main() => runApp(const GestureApp());

class GestureApp extends StatelessWidget {
  const GestureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: GestureHome(),
    );
  }
}

class GestureHome extends StatefulWidget {
  const GestureHome({super.key});

  @override
  State<GestureHome> createState() => _GestureHomeState();
}

class _GestureHomeState extends State<GestureHome> {
  String _gestureText = 'Try a gesture';

  void _updateGesture(String gesture) {
    setState(() {
      _gestureText = gesture;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gestures'),centerTitle : true),
      
      body: Center(
        child: GestureDetector(
          onTap: () => _updateGesture('Tapped'),
          onDoubleTap: () => _updateGesture('Double Tapped'),
          onLongPress: () => _updateGesture('Long Pressed'),
          onHorizontalDragEnd: (details) =>
              _updateGesture(details.primaryVelocity! > 0 ? 'Swiped Right' : 'Swiped Left'),
          onVerticalDragEnd: (details) =>
              _updateGesture(details.primaryVelocity! > 0 ? 'Swiped Down' : 'Swiped Up'),
          child: Container(
            width: 200,
            height: 200,
            color: Colors.blue,
            alignment: Alignment.center,
            child: Text(
              _gestureText,
              style: const TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
