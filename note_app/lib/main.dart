// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:note_app/add_notes.dart';
import 'package:note_app/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        appBarTheme: AppBarTheme(
          color: Colors.transparent,
          elevation: 0,
          centerTitle: true
        ),
      ),
      routes: {
        HomeScreen.ROUTE_NAME: (context) => HomeScreen(),
        AddNote.ROUTE_NAME: (context) => AddNote(),
      },
      initialRoute: HomeScreen.ROUTE_NAME,
    );
  }
}