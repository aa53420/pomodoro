import 'dart:async';
import 'package:pomodoro/models/task_model.dart';

class TimerService {
  TimerService._privateConstructor();

  static final TimerService _instance = TimerService._privateConstructor();

  factory TimerService() {
    return _instance;
  }

  TaskModel? _task;
  late void Function() _notice;

  int _workingTimeSec = 0;
  int _breakingTimeSec = 0;
  int _loop = 0;

  bool _isBreakingTime = false;

  late Timer _timer;
  bool _isPlay = false;

  void setNotice(void Function() notice) {
    _notice = notice;
  }

  void setNoticeDoNothing(){
    _notice = () {};
  }

  void play({required TaskModel task, void Function()? notice}) {
    if(notice != null) {
      _notice = notice;
    }

    // 최초로 등록일때
    if (_task == null) {
      _registerTask(
        task: task,
        isTaskChange: false,
      );
    }

    // 타스크 체인지 일때
    if (_task?.taskName != task.taskName) {
      _registerTask(
        task: task,
        isTaskChange: true,
      );
    }

    if (_isPlay) {
      return;
    }

    _timer = Timer.periodic(const Duration(seconds: 1), onTick);
    _isPlay = true;
    _notice();
  }

  void _registerTask({
    required TaskModel task,
    required bool isTaskChange,
  }) {
    _task = task;
    _isBreakingTime = false;

    _workingTimeSec = _convertMinuteToSec(task.workingTime);
    _breakingTimeSec = _convertMinuteToSec(task.breakingTime);
    _loop = 0;

    // 만약 타이머가 동작중일경우 정지 후, 모든 기준값 변경
    if(isTaskChange) {
      _timer.cancel();

      _workingTimeSec = _convertMinuteToSec(task.workingTime);
      _breakingTimeSec = _convertMinuteToSec(task.breakingTime);
      _loop = 0;
    }
  }

  int _convertMinuteToSec(int minute) {
    return minute * 60;
  }

  void onTick(Timer timer) {
    if(_loop == _task!.loop) {
      _finish();
      _notice();
      return;
    }

    if(_isBreakingTime) {
      if(_breakingTimeSec == 0) {
        _isBreakingTime = false;
        _workingTimeSec = _convertMinuteToSec(_task!.workingTime);
      }
      else {
        _breakingTimeSec = _breakingTimeSec - 1;
      }
    }
    else {
      if(_workingTimeSec == 0 ) {
        _isBreakingTime = true;
        _breakingTimeSec = _convertMinuteToSec(_task!.breakingTime);
        _loop = _loop + 1;
      }
      else {
        _workingTimeSec = _workingTimeSec - 1;
      }
    }

    _notice();
  }

  void pause() {
    _timer.cancel();
    _isPlay = false;
    _notice();
  }

  void reset() {
    _timer.cancel();

    if(_task != null) {
      _workingTimeSec = _convertMinuteToSec(_task!.workingTime);
      _breakingTimeSec = _convertMinuteToSec(_task!.breakingTime);
      _loop = 0;
    }

    _isBreakingTime = false;
    _isPlay = false;
    _notice();
  }

  // 시간 포맷으로 변경
  String getRemainTimeFormat() {
    if(_task == null) {
      return '00 : 00';
    }

    var targetSec = _isBreakingTime ? _breakingTimeSec : _workingTimeSec;
    var formattedMinPart = (targetSec / 60).floor().toString().padLeft(2, '0');
    var formattedSecPart = (targetSec % 60).floor().toString().padLeft(2, '0');

    return '$formattedMinPart : $formattedSecPart';
  }

  String getLoopFormat() {
    if(_task == null) {
      return '0 / 0';
    }

    return '$_loop / ${_task!.loop}';
  }

  bool isPlay() {
    return _isPlay;
  }

  bool isBreaking() {
    return _isBreakingTime;
  }

  double getCurrentRatio() {
    if(_task == null) {
      return 0.0;
    }

    var total = _convertMinuteToSec(_task!.workingTime);
    var curTime = _workingTimeSec;

    return (curTime / total);
  }

  void _finish() {
    reset();
    // TODO: finish event
  }

}
