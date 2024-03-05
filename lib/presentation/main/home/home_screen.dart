import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manage_app/app/manager/colors.dart';
import 'package:task_manage_app/app/manager/dimension.dart';
import 'package:task_manage_app/app/manager/strings.dart';
import 'package:task_manage_app/app/routes/routes.dart';
import 'package:task_manage_app/presentation/main/task/bloc/task_cubit.dart';
import 'package:task_manage_app/presentation/main/task/bloc/task_state.dart';
import 'package:task_manage_app/presentation/main/task/widget/task_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TaskCubit>().getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryBG,
      appBar: AppBar(
        leading: const SizedBox(),
        title: Text(Strings.taskManagerText),
        backgroundColor: AppColor.primaryColor,
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          if (state.status == Status.loading) {
            return const Center(child: CircularProgressIndicator(color: AppColor.primaryColor));
          }
          if (state.taskList == null || state.taskList?.isEmpty == true) {
            return Center(
              child: Text(
                Strings.noTaskAvailableText,
                style: const TextStyle(color: AppColor.primaryColor, fontWeight: FontWeight.w500, fontSize: 18),
              ),
            );
          }
          final taskList = state.taskList;
          return ListView.separated(
            padding: Dimensions.p14,
            itemBuilder: (context, index) {
              final task = taskList![index];
              return ItemTask(taskModel: task, index: index);
            },
            separatorBuilder: (BuildContext context, int index) => Dimensions.h16,
            itemCount: taskList?.length ?? 0,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, color: AppColor.whiteColor),
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.addTask);
        },
      ),
    );
  }
}
