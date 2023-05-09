import 'package:flutter/material.dart';
import 'package:pomodoro/models/task_model.dart';
import 'package:pomodoro/services/config_service.dart';
import 'package:pomodoro/widgets/loading.dart';
import 'package:pomodoro/widgets/notice.dart';

class ConfigRegistrationScreen extends StatefulWidget {
  const ConfigRegistrationScreen({Key? key}) : super(key: key);

  @override
  State<ConfigRegistrationScreen> createState() =>
      _ConfigRegistrationScreenState();
}

class _ConfigRegistrationScreenState extends State<ConfigRegistrationScreen> {
  late String taskName = '';
  late double workingTime = 25;
  late double breakingTime = 5;
  late double loop = 3;
  bool isLoading = false;

  void workingTimerOnChange(double newValue) {
    setState(() {
      workingTime = newValue.ceil().toDouble();
    });
  }

  void breakingTimerOnChange(double newValue) {
    setState(() {
      breakingTime = newValue.ceil().toDouble();
    });
  }

  void loopOnChange(double newValue) {
    setState(() {
      loop = newValue.ceil().toDouble();
    });
  }

  void taskNameOnChanged(String value) {
    taskName = value;
  }

  void saveConfig() async {
    if (taskName.isEmpty) {
      showAlertDialog('Task name must have a value.');
      return;
    }

    if (ConfigService().isDupleTaskName(taskName)) {
      showAlertDialog('Duplicate task name');
      return;
    }

    setState(() {
      isLoading = true;
    });

    // 설정 저장
    ConfigService().addTask(
        task: TaskModel(
            taskName: taskName,
            workingTime: workingTime.ceil(),
            breakingTime: breakingTime.ceil(),
            loop: loop.ceil()));

    var saveResult = await ConfigService().save();

    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      isLoading = false;
    });

    if (saveResult) {
      Navigator.pushReplacementNamed(
        context,
        '/config',
      );
    } else {
      Notice.showSnackBar(
        context: context,
        message: 'Error occurred while saving config file.',
        level: NoticeLevel.error,
      );
    }
  }

  Future<void> showAlertDialog(String message) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Alert'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Check'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void goBack() {
    Navigator.pushReplacementNamed(context, '/config');
  }

  @override
  Widget build(BuildContext context) {
    final customDisplaySmall =
    Theme.of(context).textTheme.displaySmall!.copyWith(color: Colors.black);

    return isLoading
        ? const Loading(
            title: 'Pomodoro',
            message: 'Saving config file',
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.background,
              elevation: 0,
              centerTitle: false,
              title: Text(
                'Registration',
                style: Theme.of(context).textTheme.displayLarge,
                textAlign: TextAlign.start,
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Task Name',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      obscureText: false,
                      keyboardType: TextInputType.name,
                      onChanged: taskNameOnChanged,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Task Name',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SliderLabel(
                      title: 'Working Timer',
                      value: workingTime,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Slider(
                      value: workingTime,
                      onChanged: workingTimerOnChange,
                      min: 1,
                      max: 60,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SliderLabel(
                      title: 'Breaking Timer',
                      value: breakingTime,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Slider(
                      value: breakingTime,
                      onChanged: breakingTimerOnChange,
                      min: 1,
                      max: 60,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SliderLabel(
                      title: 'Loop',
                      value: loop,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Slider(
                      value: loop,
                      onChanged: loopOnChange,
                      min: 1,
                      max: 10,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                      onPressed: saveConfig,
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50)),
                      child: Text(
                        'Save',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: goBack,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.secondary,
                          minimumSize: const Size(double.infinity, 50)),
                      child: Text(
                        'Back',
                        style: customDisplaySmall,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

class SliderLabel extends StatelessWidget {
  final String title;
  final double value;

  const SliderLabel({
    super.key,
    required this.value,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.displaySmall,
        ),
        Text('${value.ceil()}')
      ],
    );
  }
}
