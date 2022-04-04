// ignore_for_file: unused_local_variable, avoid_print

import 'dart:convert';

import 'package:note_app/Data/notes_model.dart';
import 'package:sqflite/sqflite.dart';

class DataUtils {
  static late Database db;

  Future<Database> get database async {
    db = await createDatabase();
    return db;
  }

  insertDatabase(noteName, description, index) async {
    var dB = await database;
    NotesModel test = NotesModel(
      id: index,
      noteTitle: noteName,
      description: description,
      messages: [
        {'initial': ''}
      ],
      time: [
        {'initial2': ''}
      ],
    );
    dB
        .insert('notes', test.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace)
        .then((value) async {
      print(value);
      // Query the table for all The Chat.
      List<Map<String, dynamic>> maps = await db.query('notes');
      // getNotes();
      // maps[index]['column']
      // print(maps[1]['title']);
      // Convert the List<Map<String, dynamic> into a List<Chat>.
    }).onError((error, stackTrace) {
      print('Error inserting the data to the database');
    });

    //   var dB = await database;
    //   await db.transaction((txn) {
    //     return txn
    //         .rawInsert('INSERT INTO notes(title:$noteName, description:$description)')
    //         .then((value) async {
    //       print('insert Successfully');

    //     }).catchError((error) {
    //       print(error);
    //     });
    //   });
    //   List<Map<String, dynamic>> maps = await dB.query('notes');
    //      print(maps.last);
    // }
  }

  createDatabase() async {
    Database database = await openDatabase(
      'note.db',
      version: 2,
      onCreate: (db, version) {
        print('Database Created');
        db
            .execute(
                'CREATE TABLE notes (id INTEGER PRIMARY KEY, title TEXT, description TEXT, messages TEXT, time TEXT)')
            .then((value) {
          print('Table Created');
        }).catchError((error) {
          print('Error creating the Table ${error.toString()}');
        });
      },
      onOpen: (db) {
        print('Database Opened');
      },
    );
    return database;
  }

  // static getDataFromDatabase(dB) async {
  //   var dB = await database;
  //   dB.rawQuery('SELECT * FROM notes').then((value) async {
  //     // Query the table for all The Chat.
  //     List<Map<String, dynamic>> maps = await db.query('notes');
  //     print(maps[0]);
  //     // maps[index]['column']
  //     // print(maps[1]['title']);
  //     // Convert the List<Map<String, dynamic> into a List<Chat>.
  //   }).onError((error, stackTrace) {
  //     print('Error getting data from database');
  //   });
  // }

  Future<List<NotesModel>> getNotes() async {
    final Database dB = await database;
    // // Query the table for all The Chat.
    // final List<Map<String, dynamic>> maps =
    // print(maps);
    final List<Map<String, dynamic>> maps = await db.query('notes');
    print(maps);
    // Convert the List<Map<String, dynamic> into a List<NoteModel>.
    List<NotesModel> notes = List.generate(maps.length, (i) {
      return NotesModel(
          id: maps[i]['id'],
          noteTitle: maps[i]['title'],
          description: maps[i]['description'],
          messages: List<Map<String, dynamic>>.from(
              json.decode(maps[i]['messages'] ?? "[]")),
          time: List<Map<String, dynamic>>.from(
              json.decode(maps[i]['time'] ?? "[]")));
    });

    return notes;
  }

  deleteDataFromDatabase() async {
    final Database db = await database;
    await db.execute("DROP TABLE IF EXISTS notes").then((value) {
      print('Table Successfuly deleted');
    }).onError((error, stackTrace) {
      print('Error Deleting the Table');
    });
  }

  creatingNewTable() async {
    await db
        .execute(
            "CREATE TABLE notes (id INTEGER PRIMARY KEY, title TEXT, description TEXT, messages TEXT, time TEXT)")
        .then((value) {
      print('new table has been created');
    }).onError((error, stackTrace) {
      print('Errorrrrrrrr');
    });
  }

  updateMessages(NotesModel note) async {
    var dB = await database;
    dB.update('notes', note.toMap(), where: 'id = ?', whereArgs: [note.id]);
  }

  Future<List<Map<String, Object?>>> getMessages() async {
    final Database dB = await database;
    return await db.query('notes');
  }
}
