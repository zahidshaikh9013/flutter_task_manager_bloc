import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manage_app/data/database/db_sevices.dart';
import 'package:task_manage_app/domain/model/task_model.dart';
import 'package:task_manage_app/presentation/main/task/bloc/task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(const TaskState());

  Future<void> getTasks() async {
    emit(state.copyWith(getTaskStatus: Status.loading));
    final data = await databaseServices.getAllTaskData();
    emit(state.copyWith(getTaskStatus: Status.success, taskList: data));
  }

  Future<bool> insertTask({required TaskModel taskModel}) async {
    final isInserted = await databaseServices.insertTask(task: taskModel);
    if (isInserted) {
      getTasks();
    }
    return isInserted;
  }

  Future<void> deleteTask({required int id}) async {
    final result = await databaseServices.deleteTask(id: id);
    if (result) {
      List<TaskModel> list = [...state.taskList ?? []];
      list.removeWhere((element) => element.id == id);
      emit(state.copyWith(taskList: list));
    }
  }

  Future<bool> updateTask({required TaskModel taskModel}) async {
    final isUpdated = await databaseServices.updateTask(task: taskModel);
    final int index = state.taskList?.indexWhere((element) => element.id == taskModel.id) ?? -1;
    List<TaskModel> list = [...state.taskList ?? []];
    list[index] = taskModel;
    emit(state.copyWith(taskList: list));
    return isUpdated;
  }
}
