// ignore_for_file: use_key_in_widget_constructors, constant_identifier_names, prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:note_app/add_notes.dart';
import 'package:note_app/note_item.dart';

class HomeScreen extends StatelessWidget {
  static const String ROUTE_NAME = 'Home Screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          backgroundColor: Colors.red,
          title: Text(
            'Note App',
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
          // ignore: prefer_const_literals_to_create_immutables
          actions: [
            Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            )
          ],
        ),
      ),
      drawer: Drawer(
        child: Container(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 48),
                width: double.infinity,
                child: Text('Note App',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    margin: EdgeInsets.all(50),
                    child: Column(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Text('Font Size',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        Divider(
                          height: 1,
                          thickness: 1,
                        ),
                        Text('Theme',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        Divider(
                          height: 1,
                          thickness: 1,
                        ),
                        Text('Delete all',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        Divider(
                          height: 1,
                          thickness: 1,
                        ),
                        Text('Contact us',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        Divider(
                          height: 1,
                          thickness: 1,
                        ),
                        Text('Rate This App',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        Divider(
                          height: 1,
                          thickness: 1,
                        ),
                        Text('Open Source License',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        Divider(
                          height: 1,
                          thickness: 1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Text('Current Version',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                            Text('1.1.2',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          shape: StadiumBorder(
            // el border el 7awalen el button
            side: BorderSide(
              color: Colors.white,
              width: 4,
            ),
          ),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushNamed(context, AddNote.ROUTE_NAME);
          }),
      body: Container(
        padding: EdgeInsets.only(top: 60, bottom: 15, left: 15, right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Text(
              'All Notes',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Number of Notes',
              style: TextStyle(color: Colors.grey, fontSize: 15),
            ),
            SizedBox(
              height: 40,
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return NoteItem();
                },
                itemCount: 10,
              ),
            )
          ],
        ),
      ),
    );
  }
}
