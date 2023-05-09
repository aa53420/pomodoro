import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pomodoro/models/task_model.dart';
import 'package:pomodoro/services/config_service.dart';
import 'package:pomodoro/services/navigation_service.dart';
import 'package:pomodoro/widgets/task_preset.dart';

class ConfigScreen extends StatefulWidget {
  const ConfigScreen({Key? key}) : super(key: key);

  @override
  State<ConfigScreen> createState() => _ConfigState();
}

class _ConfigState extends State<ConfigScreen> {
  late List<TaskModel> taskModels = [];

  void deleteTask(int index) {
    if (taskModels.length == 1) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
        'The last task cannot be deleted',
      )));
      return;
    }

    setState(() {
      TaskModel targetTask = taskModels[index];
      ConfigService().deleteTask(index: index);
      ConfigService().save();
      taskModels = ConfigService().getTaskModels();

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        '${targetTask.taskName} Task Deleted',
      )));
    });
  }

  /*
   * task 등록 페이지 이동
   */
  void goConfigRegistrationScreen() {
    Navigator.pushReplacementNamed(context, '/config/register');
  }

  @override
  void initState() {
    taskModels = ConfigService().getTaskModels();
    super.initState();
  }

  void selectTask(String taskName) {
    try {
      setState(() {
        ConfigService().selectTask(taskName);
        ConfigService().save();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
        'Task not found',
      )));
    }
  }

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
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: goConfigRegistrationScreen,
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50)),
              child: Text(
                'Add',
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                itemCount: taskModels.length,
                itemBuilder: (BuildContext context, int index) {
                  final task = taskModels[index];
                  return Slidable(
                    key: Key(task.taskName),
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      extentRatio: 0.2,
                      children: [
                        SlidableAction(
                          onPressed: (buildContext) {
                            deleteTask(index);
                          },
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                        ),
                      ],
                    ),
                    child: TaskPreset(
                      task: task,
                      onTab: selectTask,
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationService().getBottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        context: context,
      ),
    );
  }
}
