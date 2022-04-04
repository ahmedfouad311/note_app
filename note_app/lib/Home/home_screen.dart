// ignore_for_file: use_key_in_widget_constructors, constant_identifier_names, prefer_const_constructors, avoid_unnecessary_containers, must_call_super, unused_local_variable, prefer_is_empty, avoid_print

import 'package:flutter/material.dart';
import 'package:note_app/Data/constants.dart';
import 'package:note_app/Data/data_utils.dart';
import 'package:note_app/Home/add_notes.dart';
import 'package:note_app/Home/note_item.dart';
import 'package:note_app/Home/search.dart';
import 'package:note_app/Provider/notes_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String ROUTE_NAME = 'Home Screen';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int length = 0;
  DataUtils n = DataUtils();
  late NotesProvider provider;
  @override
  void initState() {
    super.initState();
    DataUtils n = DataUtils();
    n.createDatabase();
  }

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
                InkWell(
                  onTap: () {
                    showSearch(context: context, delegate: NewsSearch());
                  },
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
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
                    margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Text('Font Size',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          height: 1,
                          thickness: 1,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Theme',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          height: 1,
                          thickness: 1,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            n.deleteDataFromDatabase();
                            context.read<NotesProvider>().clearData();
                          },
                          child: Text('Delete all',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          height: 1,
                          thickness: 1,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () async {
                            n.creatingNewTable();
                            context
                                .read<NotesProvider>()
                                .refreshData(input: await n.getNotes());
                          },
                          child: Text('Create New Table',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          height: 1,
                          thickness: 1,
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
            newIndex = length + 1;
            Navigator.pushNamed(context, AddNote.ROUTE_NAME);
          }),
      body: FutureBuilder(
          future: loadData(context),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
            }
            if (snapshot.hasData) {
              return Consumer<NotesProvider>(
                builder: (BuildContext context, value, Widget? child) {
                  print("refreshed");
                  return Container(
                    padding: EdgeInsets.only(
                        top: 60, bottom: 15, left: 15, right: 15),
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
                          length.toString(),
                          // DataUtils.listOfNotes?.length.toString() ?? '',
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Expanded(
                            child: ListView.builder(
                          itemBuilder: (context, index) {
                            return NoteItem(index, value.items);
                          },
                          itemCount: value.items.length,
                        ))
                      ],
                    ),
                  );
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  loadData(BuildContext context) async {
    await n.getNotes().then(
        (value) => context.read<NotesProvider>().refreshData(input: value));
    return context.read<NotesProvider>().items;
  }
}
