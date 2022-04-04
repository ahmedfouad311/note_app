// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:note_app/Data/constants.dart';

class MessageItem extends StatefulWidget {
  int index;
  MessageItem(this.index);

  @override
  State<MessageItem> createState() => _MessageItemState();
}

class _MessageItemState extends State<MessageItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              notes.time[widget.index]['time'],
              textAlign: TextAlign.right,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onLongPress: () {
              popupMenu();
            },
            child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(0)),
              ),
              child: Text(
                notes.messages[widget.index]['message'],
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget? popupMenu() {
    PopupMenuButton(itemBuilder: (context) {
      return [
        PopupMenuItem(
          child: Row(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Icon(Icons.reply),
              Text('Reply'),
            ],
          ),
          value: 1,
        ),
        PopupMenuItem(
          child: Row(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Icon(Icons.delete),
              Text('Delete'),
            ],
          ),
          value: 2,
        ),
        PopupMenuItem(
          child: Row(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Icon(Icons.pin),
              Text('Pin'),
            ],
          ),
          value: 3,
        ),
        PopupMenuItem(
          child: Row(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Icon(Icons.copy),
              Text('Copy'),
            ],
          ),
          value: 4,
        ),
      ];
    });
  }
}
