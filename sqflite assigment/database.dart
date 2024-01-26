import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart'as p;
import 'package:precticeee/model_student.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';



final String database_name = "student_db";
final String table_name = "student_table";
final String column_id = "id";
final String coloumn_name = "name";

class DatabaseStudent {

  static DatabaseStudent? _databaseStudent;

  DatabaseStudent._createInstance();

  factory DatabaseStudent() {
    if (_databaseStudent == null) {
      _databaseStudent = DatabaseStudent._createInstance();
    }
    return _databaseStudent!;
  }

  static Database? _database;


  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database!;
  }
  Future<Database> initializeDatabase() async {
    databaseFactory = databaseFactoryFfi;
    try {
      //var databaseFactory = databaseFactoryFfi;
      var databasePath = await getDatabasesPath();

      String path = p.join(databasePath,database_name);
      Database database = await openDatabase(
          path, version: 1, onCreate: (Database db, int version) {
        db.execute('''
       create table $table_name (
       $column_id INTEGER PRIMARY KEY AUTOINCREMENT,
       $coloumn_name text not null
       )
       ''');
      });

      return database;
    } catch (e) {
      print("DatabaseError ${e.toString()}");
      return null!;
    }
  }

  Future<bool> addStudent(ModelStudent modelStudent) async {
    try {
      Database db = await this.database;
      var result = await db.insert(table_name, modelStudent.toMap());
      return true;
    } catch (e) {
      print("Database error add function ${e.toString()}");
      return false;
    }
  }

  //update student
  Future<bool> updateStudent(ModelStudent modelStudent) async {
    try {
      Database db = await this.database;
      var result = await db.update(
        table_name,
        modelStudent.toMap(),
        where: "$column_id=?",
        whereArgs: [modelStudent.id],
      );
      return true;
    } catch (e) {
      print("Database error update function ${e.toString()}");
      return false;
    }
  }

  Future<bool> deleteStudentById(String id) async {
    try {
      Database db = await this.database;
      var result = await db.delete(
        table_name,
        where: "$column_id=?",
        whereArgs: [id],
      );
      return true;
    } catch (e) {
      print("Database error delete function ${e.toString()}");
      return false;
    }
  }

  Future<bool> deleteAllStudents() async {
    try {
      Database db = await this.database;
      var result = await db.delete(table_name);
      return true;
    } catch (e) {
      print("Database error delete all table ${e.toString()}");
      return false;
    }
  }

  Future<List<ModelStudent>> getAllStudents() async {
    List<ModelStudent> list_student = [];

    try {
      Database db = await this.database;
      List<Map<String, dynamic>> result = await db.query(table_name);
      if (result.length > 0) {
        for (var i = 0; i < result.length; i++) {
          ModelStudent modelStudent = ModelStudent.ModelOjjectFromMap(
              result[i]);
          list_student.add(modelStudent);
        }
      }
      return list_student;
    } catch (e) {
      print("Database error getAllStudents ${e.toString()}");
      return list_student;
    }
  }

  Future<int> getCountStudents() async {
    try {
      Database db = await this.database;
      List<Map<String, dynamic>> result = await db.query(table_name);
      return result.length;
    } catch (e) {
      print("Database error getCountStudents ${e.toString()}");
      return 0;
    }
  }
}
