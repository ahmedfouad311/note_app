// ignore_for_file: use_key_in_widget_constructors, constant_identifier_names, prefer_const_constructors, must_be_immutable, avoid_unnecessary_containers, avoid_print, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:note_app/Data/constants.dart';
import 'package:note_app/Data/data_utils.dart';
import 'package:provider/provider.dart';

import '../Provider/notes_provider.dart';

class AddNote extends StatefulWidget {
  static const String ROUTE_NAME = 'Add Note';
  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  String noteName = '';
  String description = '';
  late NotesProvider provider;

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    return Container(
      color: Colors.white,
      child: Container(
          child: Scaffold(
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
              ),
            ],
          ),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
          margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.07,
              vertical: MediaQuery.of(context).size.height * 0.06),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            // ignore: prefer_const_literals_to_create_immutables
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Create New Note',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                    onChanged: (text) {
                      noteName = text;
                    },
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please Enter Note Name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: 'Enter Note Name',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    maxLines: 3,
                    minLines: 3,
                    onChanged: (text) {
                      description = text;
                    },
                    decoration: InputDecoration(
                        hintText: 'Enter Note Description',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        )),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please Enter Note Description';
                      }
                    },
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        )),
                        backgroundColor: MaterialStateProperty.all(Colors.red)),
                    onPressed: () {
                      if (formKey.currentState!.validate() == true) {
                        DataUtils n = DataUtils();
                        n.insertDatabase(noteName, description,
                            context.read<NotesProvider>().items.length);
                        n.getNotes().then((value) {
                          return context
                              .read<NotesProvider>()
                              .refreshData(input: value);
                        });
                        Navigator.pop(context);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Create',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
