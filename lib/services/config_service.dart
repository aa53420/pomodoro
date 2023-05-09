import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pomodoro/models/task_model.dart';
import 'dart:convert';

class ConfigService {
  ConfigService._privateConstructor();

  static final ConfigService _instance = ConfigService._privateConstructor();

  factory ConfigService() {
    return _instance;
  }

  final String configFileName = 'config.json';

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _configFile async {
    final path = await _localPath;
    return File('$path/$configFileName');
  }

  List<TaskModel> _taskModels = [];

  List<TaskModel> getTaskModels() {
    return _taskModels;
  }

  List<TaskModel> addTask({required TaskModel task}) {
    _taskModels.add(task);
    return _taskModels;
  }

  List<TaskModel> deleteTask({required int index}) {
    if (_taskModels.length == 1) {
      final task = _taskModels.first;
      task.isChecked = true;

      return _taskModels;
    }

    _taskModels.removeAt(index);

    // 지우고 난 후, checked된게 있는지 확인
    if (!_isAnythingChecked()) {
      final task = _taskModels.first;
      task.isChecked = true;
    }

    return _taskModels;
  }

  bool _isAnythingChecked() {
    for (var task in _taskModels) {
      if (task.isChecked) {
        return true;
      }
    }

    return false;
  }

  bool isDupleTaskName(String taskName) {
    return _taskModels.where((task) {
      if (task.taskName == taskName) {
        return true;
      }
      return false;
    }).isNotEmpty;
  }

  Future<bool> save() async {
    File configFile = await _configFile;
    if (configFile.existsSync()) {
      try {
        var defaultTaskData = jsonEncode(_taskModels);
        configFile.writeAsStringSync(defaultTaskData);

        return true;
      } catch (e) {
        return false;
      }
    }

    return false;
  }

  TaskModel _findTaskByKey(String taskName) {
    try{
      final task = _taskModels.where((task) {
        if (task.taskName == taskName) {
          return true;
        }
        return false;
      }).first;

      return task;
    } catch (e) {
      rethrow;
    }
  }

  TaskModel findSelectedTask(){
    return _taskModels.where((task) {
      if (task.isChecked) {
        return true;
      }
      return false;
    }).first;
  }

  void selectTask(String taskName){
    var task = _findTaskByKey(taskName);

    if(task.isChecked){
      return;
    }

    // 모든 체크를 다 해제 하고 요청 task만 체크한다.
    for(var task in _taskModels) {
      task.isChecked = false;
    }

    task.isChecked = true;
  }

  /*
   * 파일이 없으면 생성하고,
   * 있으면 읽는다.
   */
  Future<bool> initConfigSetting() async {
    File configFile = await _configFile;
    if (!configFile.existsSync()) {
      try {
        List<TaskModel> taskModels = [
          TaskModel(
              taskName: "Default",
              workingTime: 25,
              breakingTime: 5,
              loop: 3,
              isChecked: true),
        ];

        configFile.createSync(
          recursive: true,
          exclusive: false,
        );

        var defaultTaskData = jsonEncode(taskModels);
        configFile.writeAsStringSync(defaultTaskData);
      } catch (e) {
        return false;
      }
    }

    try {
      final taskJsonString = await configFile.readAsString();
      List<dynamic> tasks = json.decode(taskJsonString);

      _taskModels.clear();

      for (var task in tasks) {
        _taskModels.add(TaskModel.fromJson(task));
      }
    } catch (e) {
      return false;
    }

    return true;
  }
}
