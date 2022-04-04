// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:note_app/Home/add_notes.dart';
import 'package:note_app/Home/home_screen.dart';
import 'package:note_app/Note_Details/note_details_screen.dart';
import 'package:note_app/Provider/notes_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
      providers:[
        ChangeNotifierProvider(create: (_) => NotesProvider()),
      ],
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        appBarTheme: AppBarTheme(
            color: Colors.transparent, elevation: 0, centerTitle: true),
      ),
      routes: {
        HomeScreen.ROUTE_NAME: (context) => HomeScreen(),
        AddNote.ROUTE_NAME: (context) => AddNote(),
        NoteDetailsScreen.ROUTE_NAME: (context) => NoteDetailsScreen(),
      },
      initialRoute: HomeScreen.ROUTE_NAME,
    );
  }
}
