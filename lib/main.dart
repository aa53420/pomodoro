import 'package:flutter/material.dart';
import 'package:pomodoro/screens/about/about_screen.dart';
import 'package:pomodoro/screens/config/config_registration_screen.dart';
import 'package:pomodoro/screens/config/config_screen.dart';
import 'package:pomodoro/screens/home_screen.dart';
import 'package:pomodoro/screens/timer/timer_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/timer': (context) => const TimerScreen(),
        '/config': (context) => const ConfigScreen(),
        '/config/register': (context) => const ConfigRegistrationScreen(),
        // '/about': (context) => const AboutScreen(),
      },
      title: 'Pomodoro App',
      theme: ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: Color(0xFFFF8A68),
          onPrimary: Color(0xFFFF8A68),
          secondary: Color(0xFFFFEAD1),
          onSecondary: Color(0xFFFFEAD1),
          error: Color(0xFFFF8A68),
          onError: Color(0xFFFF8A68),
          background: Color(0xFF34393E),
          onBackground: Color(0xFF34393E),
          surface: Color(0xFFFFFFFF),
          onSurface: Color(0xFFFFFFFF),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Colors.white,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w400,
            fontSize: 32,
          ),
          displayMedium: TextStyle(
            color: Colors.white,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w400,
            fontSize: 24,
          ),
          displaySmall: TextStyle(
            color: Colors.white,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
