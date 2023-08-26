import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meditation Timer',
      theme: ThemeData(
        primaryColor: Colors.orange,
        accentColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MeditationTimerApp(),
    );
  }
}

class MeditationTimerApp extends StatefulWidget {
  @override
  _MeditationTimerAppState createState() => _MeditationTimerAppState();
}

class _MeditationTimerAppState extends State<MeditationTimerApp> {
  int minutes = 5;
  int seconds = 0;
  bool isRunning = false;
  late Timer _timer;

  void startTimer() {
    isRunning = true;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (minutes == 0 && seconds == 0) {
        stopTimer();
        return;
      }
      if (seconds == 0) {
        setState(() {
          minutes--;
          seconds = 59;
        });
      } else {
        setState(() {
          seconds--;
        });
      }
    });
  }

  void stopTimer() {
    isRunning = false;
    _timer.cancel();
  }

  void resetTimer() {
    if (!isRunning) {
      setState(() {
        minutes = 5;
        seconds = 0;
      });
    }
  }

  void setCustomTime(int? value) {
    if (value != null) {
      setState(() {
        minutes = value;
        seconds = 0;
      });
    }
  }

  @override
  void dispose() {
    if (isRunning) {
      stopTimer();
    }
    super.dispose();
  }

  String formatTime(int value) {
    return value.toString().padLeft(2, '0');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Meditation Timer')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Meditation Time',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '${formatTime(minutes)}:${formatTime(seconds)}',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: isRunning ? null : startTimer,
              child: Text('Start'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: isRunning ? stopTimer : null,
              child: Text('Stop'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: resetTimer,
              child: Text('Reset'),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Set Custom Time:'),
                SizedBox(width: 10),
                DropdownButton<int>(
                  value: minutes,
                  onChanged: isRunning ? null : setCustomTime,
                  items: List.generate(60, (index) => index + 1).map((value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text('$value minutes'),
                    );
                  }).toList(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
