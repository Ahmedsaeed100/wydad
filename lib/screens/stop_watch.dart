import 'dart:async';

import 'package:flutter/material.dart';

class StopWatch extends StatefulWidget {
  const StopWatch({Key? key}) : super(key: key);

  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  Duration duration = const Duration();
  Timer? timer;
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      addTimer();
    });
  }

  void addTimer() {
    const addSeconds = 1;
    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      duration = Duration(seconds: seconds);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(
        "sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss");
    return Scaffold(
      body: Center(
        child: buildTime(),
      ),
    );
  }

  Widget buildTime() {
    String towDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = towDigits(duration.inMinutes.remainder(60));
    final seconds = towDigits(duration.inSeconds.remainder(60));
    final hours = towDigits(duration.inHours.remainder(60));
    return Text(
      '$hours:$minutes:$seconds',
      style: const TextStyle(
        fontSize: 80,
      ),
    );
  }
}
