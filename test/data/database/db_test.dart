import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:task_manage_app/data/database/db_sevices.dart';
import 'package:task_manage_app/domain/model/task_model.dart';

Future main() async {
  Database? db;
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  test("Check existence of database and create", () async {
    db = await databaseServices.checkDb(isTest: true);
    expect(db == null, false, reason: "If database is created, the value should be false");
  });

  test("Get all tasks data, expecting no tasks for the first time", () async {
    List<TaskModel> taskList =
        await databaseServices.getAllTaskData(isTest: true, testDatabase: db);
    print("Total task list --> ${taskList.length}");
  });

  test("Insert 2 tasks one by one and fetch all tasks on each insertion", () async {
    List<TaskModel> taskList;
    bool addTask;
    addTask = await databaseServices.insertTask(
      isTest: true,
      testDatabase: db,
      task: TaskModel(
        id: 1,
        title: "Testing task 1",
        description: "This is the description for testing task 1",
        status: TaskStatusEnum.complete,
        createdAt: DateTime.now(),
      ),
    );
    expect(addTask, true, reason: "Task added successfully");

    if (addTask) {
      taskList = await databaseServices.getAllTaskData(isTest: true, testDatabase: db);
      expect(taskList.isNotEmpty, true,
          reason: "Task entry was successful, so there should be one entry");

      addTask = await databaseServices.insertTask(
        isTest: true,
        testDatabase: db,
        task: TaskModel(
          id: 2,
          title: "Testing task 2",
          description: "This is the description for testing task 2",
          status: TaskStatusEnum.pending,
          createdAt: DateTime.now(),
        ),
      );
      expect(addTask, true, reason: "Second Task added successfully");

      if (addTask) {
        taskList = await databaseServices.getAllTaskData(isTest: true, testDatabase: db);
        expect(taskList.length >= 2, true,
            reason: "Second Task entry was successful, so there should be one entry");
      }
    } else {
      throwsA("NO TASK ADDED");
    }
  });

  test("Delete task failed", () async {
    bool isDataDeleted = await databaseServices.deleteTask(isTest: true, testDatabase: db, id: 3);
    print("Data deleted ----> $isDataDeleted because the id provided is wrong");
  });

  test("Delete task success", () async {
    List<TaskModel> taskList;
    taskList = await databaseServices.getAllTaskData(isTest: true, testDatabase: db);
    print("Total task list before deleting --> ${taskList.length}");
    bool isDataDeleted = await databaseServices.deleteTask(isTest: true, testDatabase: db, id: 2);
    print("Data deleted ----> $isDataDeleted because the id provided is correct");
    taskList = await databaseServices.getAllTaskData(isTest: true, testDatabase: db);
    print("Total task list after deleting --> ${taskList.length}");
  });

  test("Update task success", () async {
    List<TaskModel> taskList;
    taskList = await databaseServices.getAllTaskData(isTest: true, testDatabase: db);
    print("1st task status before updating --> ${taskList.first.status}");
    TaskModel updatedTask = taskList.first;
    updatedTask.status = TaskStatusEnum.pending;
    bool isDataUpdated = await databaseServices.updateTask(isTest: true, testDatabase: db, task: updatedTask);
    print("Data updated ----> $isDataUpdated");
    taskList = await databaseServices.getAllTaskData(isTest: true, testDatabase: db);
    print("1st task status after updating --> ${taskList.first.status}");
  });
}
