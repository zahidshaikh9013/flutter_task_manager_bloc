import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:task_manage_app/domain/model/task_model.dart';

enum Status { loading, failure, success }

@immutable
class TaskState extends Equatable {
  final Status? status;
  final List<TaskModel>? taskList;

  const TaskState({
    this.status,
    this.taskList,
  });

  TaskState copyWith({
    Status? getTaskStatus,
    List<TaskModel>? taskList,
  }) {
    return TaskState(
      status: getTaskStatus ?? this.status,
      taskList: taskList ?? this.taskList,
    );
  }

  @override
  List<Object?> get props => [status, taskList];
}
