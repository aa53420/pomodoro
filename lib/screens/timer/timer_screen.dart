import 'package:flutter/material.dart';
import 'package:pomodoro/models/task_model.dart';
import 'package:pomodoro/services/config_service.dart';
import 'package:pomodoro/services/navigation_service.dart';
import 'package:pomodoro/services/timer_service.dart';
import 'package:pomodoro/widgets/task_progress.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({Key? key}) : super(key: key);

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  late TaskModel task;
  bool isPlay = false;

  @override
  void initState() {
    task = ConfigService().findSelectedTask();
    TimerService().setNotice(notice);

    super.initState();
  }

  void playOnPressed() {
    TimerService().play(
      task: task,
    );
  }

  void pauseOnPressed() {
    TimerService().pause();
  }

  void resetOnPressed() {
    TimerService().reset();
  }

  void notice() {
    setState(() {});
  }

  @override
  void dispose() {
    TimerService().setNoticeDoNothing();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        centerTitle: false,
        title: Text(
          task.taskName,
          style: Theme.of(context).textTheme.displayLarge,
          textAlign: TextAlign.start,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TaskProgress(
                timerText: TimerService().getRemainTimeFormat(),
                loopText: TimerService().getLoopFormat(),
                value: 0.1,
                backgroundColor: Theme.of(context).colorScheme.secondary,
                foregroundColor: Theme.of(context).colorScheme.primary,
              ),
              Text(
                !TimerService().isPlay() ? 'Ready' :
                TimerService().isBreaking() ? 'Breaking' : 'Working',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 35,
                ),
                width: 270,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: resetOnPressed,
                        iconSize: 50,
                        icon: const Icon(
                          Icons.restart_alt_rounded,
                        )),
                    TimerService().isPlay()
                        ? IconButton(
                            onPressed: pauseOnPressed,
                            iconSize: 50,
                            icon: const Icon(
                              Icons.pause_circle,
                            ))
                        : IconButton(
                            onPressed: playOnPressed,
                            iconSize: 50,
                            icon: const Icon(
                              Icons.play_circle,
                            ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavigationService().getBottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        context: context,
      ),
    );
  }
}
