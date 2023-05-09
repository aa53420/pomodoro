import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class TaskModel {
  final String taskName;
  final int workingTime;
  final int breakingTime;
  final int loop;
  bool isChecked;

  TaskModel({
    required this.taskName,
    required this.workingTime,
    required this.breakingTime,
    required this.loop,
    this.isChecked = false
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => _$TaskModelFromJson(json);
  Map<String, dynamic> toJson() => _$TaskModelToJson(this);


}

TaskModel _$TaskModelFromJson(Map<String, dynamic> json) => TaskModel(
  taskName: json['taskName'] as String,
  workingTime: json['workingTime'] as int,
  breakingTime: json['breakingTime'] as int,
  loop: json['loop'] as int,
  isChecked: json['isChecked'] as bool,
);

Map<String, dynamic> _$TaskModelToJson(TaskModel instance) => <String, dynamic>{
  'taskName': instance.taskName,
  'workingTime': instance.workingTime,
  'breakingTime': instance.breakingTime,
  'loop': instance.loop,
  'isChecked': instance.isChecked
};


