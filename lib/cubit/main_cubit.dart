import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_app/cubit/states.dart';

class MainCubit extends Cubit<MainStates> {
  MainCubit() : super(InitState());

  static MainCubit get(context) => BlocProvider.of(context);

  initSql() async {
    var databasesPath = await getDatabasesPath();
    String path = join(
      databasesPath,
      'goals.db',
    );
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
        '''CREATE TABLE Goals (
        id INTEGER PRIMARY KEY,
        name TEXT
        )''',
      );
    });
  }

  var addTextController = TextEditingController();
  var updateTextController = TextEditingController();

  List<Map> gaolsList = [];

  getData() async {
    var databasesPath = await getDatabasesPath();
    String path = join(
      databasesPath,
      'goals.db',
    );
    Database database = await openDatabase(path);
    await database.rawQuery('SELECT * FROM Goals').then((value) {
      gaolsList = value;
      emit(GetDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetDataErrorState());
    });
    database.close();
  }

  insertData(String name) async {
    var databasesPath = await getDatabasesPath();
    String path = join(
      databasesPath,
      'goals.db',
    );
    Database database = await openDatabase(path);

    await database
        .rawInsert('INSERT INTO Goals(name) VALUES(?)', [name]).then((value) {
      emit(InsertDataSuccessState());
    }).catchError((error) {
      emit(InsertDataErrorState());
      print(error.toString());
    });
    database.close();
  }

  removeData(id) async {
    var databasesPath = await getDatabasesPath();
    String path = join(
      databasesPath,
      'goals.db',
    );
    Database database = await openDatabase(path);
    await database
        .rawDelete('DELETE FROM Goals WHERE id = ?', ['$id']).then((value) {
      emit(RemoveDataSuccessState());
    }).catchError((error) {
      emit(RemoveDataErrorState());
      print(error.toString());
    });
    database.close();
  }
}
