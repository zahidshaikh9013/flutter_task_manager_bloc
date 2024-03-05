import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task_manage_app/app/manager/colors.dart';
import 'package:task_manage_app/app/routes/routes.dart';
import 'package:task_manage_app/domain/model/task_model.dart';
import 'package:task_manage_app/presentation/main/task/bloc/task_cubit.dart';

class ItemTask extends StatefulWidget {
  const ItemTask({super.key, required this.taskModel, required this.index});

  final TaskModel taskModel;
  final int index;

  @override
  State<ItemTask> createState() => ItemTaskState();
}

class ItemTaskState extends State<ItemTask> {
  TaskModel get task => widget.taskModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(AppRoutes.addTask, arguments: task);
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0).copyWith(right: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColor.primaryColor)),
                alignment: Alignment.center,
                child: Text(
                  "${widget.index + 1}",
                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: AppColor.primaryColor),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title ?? "",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      DateFormat('dd MMM, yyyy').format(task.createdAt ?? DateTime.now()),
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => context.read<TaskCubit>().deleteTask(id: task.id!),
                icon: const Icon(Icons.delete, color: AppColor.primaryColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
