import 'package:flutter/material.dart';
import 'package:pomodoro/models/task_model.dart';

class TaskPreset extends StatelessWidget {
  final TaskModel task;
  final Function(String) onTab;

  const TaskPreset({
    Key? key,
    required this.task,
    required this.onTab,
  }) : super(key: key);

  String taskNameScissor(String taskName) {
    if (taskName.length > 15) {
      return '${taskName.substring(0, 12)}...';
    }
    return taskName;
  }

  @override
  Widget build(BuildContext context) {
    final customDisplaySmall =
        Theme.of(context).textTheme.displaySmall!.copyWith(color: Colors.black);

    final customDisplayMedium = Theme.of(context)
        .textTheme
        .displayMedium!
        .copyWith(color: Colors.black);

    return Container(
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(0),
        boxShadow: [
          BoxShadow(
            blurRadius: 0,
            offset: const Offset(0, 0),
            color: Colors.black.withOpacity(0.5),
          )
        ],
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.check_circle),
            iconSize: 30,
            color: task.isChecked
                ? Colors.green
                : Colors.black.withOpacity(0.3),
            onPressed: () {
              onTab(task.taskName);
            },
          ),
          Text(
            taskNameScissor(task.taskName),
            style: customDisplayMedium,
            textAlign: TextAlign.start,
          ),
          Text(
            '${task.workingTime} / ${task.breakingTime} / ${task.loop}',
            style: customDisplaySmall,
          )
        ],
      ),
    );
  }
}
