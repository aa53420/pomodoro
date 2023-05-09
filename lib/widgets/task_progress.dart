import 'package:flutter/material.dart';

class TaskProgress extends StatelessWidget {
  final double value;
  final String? timerText;
  final String? loopText;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const TaskProgress({
    Key? key,
    required this.value,
    this.timerText,
    this.loopText,
    this.backgroundColor,
    this.foregroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var customTimerTextTheme = Theme.of(context)
        .textTheme
        .displayLarge!
        .copyWith(fontWeight: FontWeight.w600);

    var customLoopTextTheme = Theme.of(context)
        .textTheme
        .displayMedium!
        .copyWith(fontWeight: FontWeight.w600);

    return Column(
      children: [
        Transform.translate(
          offset: const Offset(0, 185),
          child: Column(
            children: [
              Text(
                timerText ?? '',
                style: customTimerTextTheme,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                loopText ?? '',
                style: customLoopTextTheme,
              )
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 40,
            horizontal: 50,
          ),
          height: 300,
          width: double.infinity,
          child: CircularProgressIndicator(
            value: value,
            strokeWidth: 40,
            backgroundColor: backgroundColor,
            color: foregroundColor,
          ),
        ),
      ],
    );
  }
}
