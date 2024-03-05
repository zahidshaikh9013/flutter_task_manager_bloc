import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manage_app/app/manager/colors.dart';
import 'package:task_manage_app/app/routes/routes.dart';
import 'package:task_manage_app/app/utils/globals.dart';
import 'package:task_manage_app/domain/model/task_model.dart';
import 'package:task_manage_app/presentation/main/task/bloc/task_cubit.dart';

import 'presentation/main/home/home_screen.dart';
import 'presentation/main/task/screen/crud_task_screen.dart';

class TaskManagerApp extends StatefulWidget {
  const TaskManagerApp({super.key});

  @override
  State<TaskManagerApp> createState() => TaskManagerAppState();
}

class TaskManagerAppState extends State<TaskManagerApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TaskCubit()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          primaryColor: AppColor.primaryColor,
          floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: AppColor.primaryColor),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.home,
        builder: (context, child) {
          screenWidth = MediaQuery.of(context).size.width;
          screenHeight = MediaQuery.of(context).size.height;
          child = MediaQuery(data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling), child: child!);
          return child;
        },
        onGenerateRoute: (settings) {
          final name = settings.name;
          final args = settings.arguments;

          Widget screen = const SizedBox();

          switch (name) {
            case AppRoutes.home:
              screen = const HomeScreen();
              break;
            case AppRoutes.addTask:
              screen = CrudTaskScreen(task: args as TaskModel?);
              break;
            default:
          }

          return MaterialPageRoute(builder: (_) => screen);
        },
      ),
    );
  }
}
