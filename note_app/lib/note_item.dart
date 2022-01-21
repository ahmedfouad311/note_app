// ignore_for_file: use_key_in_widget_constructors, avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';

class NoteItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Row(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          CircleAvatar(
            child: Icon(Icons.question_answer),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text(
                      'Note Name',
                    ),
                    Text(
                      '11:00 PM',
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Note Description',
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
