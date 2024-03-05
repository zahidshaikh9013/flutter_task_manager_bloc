import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_manage_app/domain/model/task_model.dart';

final databaseServices = DatabaseServices.instance;

class DatabaseServices {
  DatabaseServices._();

  static DatabaseServices get instance => DatabaseServices._();

  Database? database;

  static const keyTableTaskData = "taskData";
  static const dbName = "task_manage.db";
  static const keyId = "id";
  static const keyTitle = "title";
  static const keyDescription = "description";
  static const keyDateTime = "createdAt";
  static const keyStatus = "status";

  /// if database is null then create a new database otherwise return database.
  Future<Database> checkDb() async {
    if (database != null) {
      return database!;
    } else {
      return await createDb();
    }
  }

  /// create a new database
  Future<Database> createDb() async {
    final directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, dbName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        String query =
            "CREATE TABLE $keyTableTaskData ($keyId INTEGER PRIMARY KEY AUTOINCREMENT, $keyTitle TEXT,$keyDescription TEXT, $keyDateTime TEXT, $keyStatus TEXT)";
        await db.execute(query);
      },
    );
  }

  /// get all task from database
  Future<List<TaskModel>> getAllTaskData() async {
    database = await checkDb();

    String query = "SELECT * from $keyTableTaskData";
    final result = await database!.rawQuery(query);

    final listOfTaskModel = result.map((e) => TaskModel.fromJson(e)).toList();
    return listOfTaskModel;
  }

  /// insert task into database
  Future<bool> insertTask({required TaskModel task}) async {
    final model = task.toJson();
    database = await checkDb();
    final result = await database?.insert(
          keyTableTaskData,
          model,
          conflictAlgorithm: ConflictAlgorithm.replace,
        ) ??
        -1;
    if (result >= 0) {
      return true;
    }
    return false;
  }

  /// delete task from database
  Future<bool> deleteTask({required int id}) async {
    database = await checkDb();
    final result = await database?.delete(keyTableTaskData, where: "$keyId = ?", whereArgs: [id]);

    if (result == 1) {
      return true;
    }
    return false;
  }

  /// update task in database
  Future<bool> updateTask({required TaskModel task}) async {
    final model = task.toJson();
    database = await checkDb();
    final result = await database?.update(keyTableTaskData, model, where: "$keyId = ?", whereArgs: [task.id]);
    if (result == 1) {
      return true;
    }
    return false;
  }
}
