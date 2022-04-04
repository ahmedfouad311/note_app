// ignore_for_file: prefer_const_constructors, annotate_overrides

import 'package:flutter/material.dart';

class NewsSearch extends SearchDelegate {
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      inputDecorationTheme: InputDecorationTheme(
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent)),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: Colors.red,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        color: Colors.transparent,
        //app bar color I wanted
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          // de build in function goa el delegate kol wazeftha 2nha hat3ml call le el function el ta7t el 2smaha buildResults
          showResults(context);
        },
        icon: Icon(
          Icons.search,
          color: Theme.of(context).primaryColor,
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(Icons.clear, color: Colors.red),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('Search Results');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Stack(children: [
      Container(
        color: Colors.white,
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(color: Colors.transparent),
      ),
    ]);
  }
}
