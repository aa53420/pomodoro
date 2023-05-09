import 'package:flutter/material.dart';
import 'package:pomodoro/services/navigation_service.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutState();
}

class _AboutState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        centerTitle: false,
        title: Text(
          NavigationService().getNameByCurrentIndex(),
          style: Theme.of(context).textTheme.displayLarge,
          textAlign: TextAlign.start,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: const Padding(
        padding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        child: Text('About'),
      ),
      bottomNavigationBar: NavigationService().getBottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        context: context,
      ),
    );
  }
}
