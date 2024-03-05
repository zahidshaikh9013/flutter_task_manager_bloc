import 'package:task_manage_app/app/utils/extensions.dart';

class TaskModel {
  int? id;
  String? title;
  String? description;
  DateTime? createdAt;
  TaskStatusEnum? status;

  TaskModel({
    this.id,
    this.title,
    this.description,
    this.createdAt,
    this.status,
  });

  TaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    createdAt = json['createdAt'].toString().toDateTime();
    status = TaskStatusEnum.values.byName(json['status'] ?? TaskStatusEnum.pending.name);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['createdAt'] = createdAt.toString();
    data['status'] = status?.name;
    return data;
  }
}

enum TaskStatusEnum { pending, complete }
