import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pomodoro/services/config_service.dart';
import 'package:pomodoro/widgets/loading.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  late Future<bool> isEnvironmentInit;
  late Timer delayTimer;

  @override
  void initState() {
    isEnvironmentInit = ConfigService().initConfigSetting();
    delayTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      goTimerScreen();
    });

    super.initState();
  }

  @override
  void dispose() {
    delayTimer.cancel();
    super.dispose();
  }

  void goTimerScreen() {
    Navigator.pushReplacementNamed(context, '/timer');
  }


  @override
  Widget build(BuildContext context) {
    return const Loading(
      title: 'Pomodoro',
      message: 'Loading config file',
    );
  }
}
