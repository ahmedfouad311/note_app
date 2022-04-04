// ignore_for_file: use_key_in_widget_constructors, avoid_unnecessary_containers, prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:note_app/Data/constants.dart';
import 'package:note_app/Data/notes_model.dart';
import 'package:note_app/Note_Details/note_details_screen.dart';

class NoteItem extends StatelessWidget {
  int index;
  List<NotesModel>? listNotes;
  NoteItem(this.index, this.listNotes);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        notes = listNotes![index];
        Navigator.pushNamed(
          context,
          NoteDetailsScreen.ROUTE_NAME,
        );
      },
      child: Container(
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(listNotes![index].noteTitle.toString()),
                    ],
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      listNotes![index].description.toString(),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              listNotes![index].time.last['time'] ?? "",
            ),
          ],
        ),
      ),
    );
  }
}
