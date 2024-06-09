import 'package:flutter/material.dart';
import 'dart:async';

import 'package:remote_collab_tool/common/appbar/appbar.dart';
import 'package:remote_collab_tool/common/navbar/navbar.dart';

class PomodoroTimer extends StatefulWidget {
  @override
  _PomodoroTimerState createState() => _PomodoroTimerState();
}

class _PomodoroTimerState extends State<PomodoroTimer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Timer _timer;
  int _seconds = 1500; // 25 minutes in seconds
  bool _isActive = false;
  bool _isBreak = false;
  Map<String, int> _breakDurations = {
    'Pomodoro': 1500, // 25 minutes
    'Short Break': 300, // 5 minutes
    'Water Break': 120, // 2 minutes
    'Food Break': 1800, // 30 minutes
  };
  List<DateTime> _breakTimes = []; // Stores break timestamps

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: _seconds),
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (!_isBreak) {
          _controller.reverse(from: 1.0);
        } else {
          print('Break time: ${DateTime.now()}');
          resetTimer();
        }
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
  }

  int _displaySeconds = 0;

  void startTimer(int duration) {
    _isActive = true;
    _seconds = duration;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds > 0) {
          _seconds--;
          _displaySeconds = _seconds; // Update display every second
        } else {
          _isActive = false;
          _timer.cancel();
          _controller.reset();
          // Optionally, add notification or sound
        }
      });
      if (_isActive) {
        _controller.forward();
      } else {
        _controller.stop();
      }
    });
  }

  String _formatTime(int seconds) {
    // Use _displaySeconds instead of _seconds for display
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    String formattedTime =
        '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
    return formattedTime;
  }

  void pauseTimer() {
    setState(() {
      _isActive = false;
      _timer.cancel();
      _controller.stop();
    });
  }

  void resetTimer() {
    setState(() {
      _isActive = false;
      _isBreak = false;
      _seconds = 1500;
      _timer.cancel();
      _controller.reset();
    });
  }

  void startBreak(String breakType) {
    if (_isActive) {
      pauseTimer();
      _isBreak = true;
      startTimer(_breakDurations[breakType]!);
      _breakTimes.add(DateTime.now()); // Add break time to list
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar(),
      bottomNavigationBar: MyBottomNavigationBar(),
      body: Center(
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            width: 300,
            height: 550,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text("task name here",
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromARGB(255, 17, 0, 6),
                      )),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 200,
                  width: 200,
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.pinkAccent.withOpacity(0.5),
                            ),
                          ),
                          Positioned(
                            top: 100 * (1 - _controller.value),
                            child: Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Text(
                  _formatTime(_displaySeconds),
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        startTimer(1500); // 25 minutes
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.pinkAccent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Pomodoro',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        startBreak('Short Break'); // 5 minutes
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Short Break',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        startBreak('Water Break'); // 2 minutes
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Water Break',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        startBreak('Food Break'); // 30 minutes
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.orangeAccent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Food Break',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(Icons.play_arrow),
                      iconSize: 48,
                      onPressed: () {
                        startTimer(_seconds);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.pause),
                      iconSize: 48,
                      onPressed: () {
                        pauseTimer();
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.stop),
                      iconSize: 48,
                      onPressed: () {
                        resetTimer();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
