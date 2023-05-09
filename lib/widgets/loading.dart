import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final String title;
  final String message;

  const Loading({
    super.key,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.displayLarge,
        ),
        Text(
          message,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        const SizedBox(
          height: 10,
        ),
        const CircularProgressIndicator()
      ],
    );
  }
}
