// ignore_for_file: constant_identifier_names, use_key_in_widget_constructors, prefer_const_constructors, must_be_immutable, avoid_unnecessary_containers, prefer_typing_uninitialized_variables, unused_local_variable, unnecessary_new, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:note_app/Data/data_utils.dart';
import 'package:note_app/Note_Details/message_item.dart';
import 'package:note_app/Home/search.dart';
import 'package:note_app/Note_Details/sound_recorder.dart';
import 'package:note_app/Provider/notes_provider.dart';
import 'package:provider/provider.dart';
import '../Data/constants.dart';
import 'package:intl/intl.dart';

class NoteDetailsScreen extends StatefulWidget {
  static const String ROUTE_NAME = 'Note Details Screen';

  @override
  State<NoteDetailsScreen> createState() => _NoteDetailsScreenState();
}

class _NoteDetailsScreenState extends State<NoteDetailsScreen> {
  String message = '';
  final recorder = SoundRecorder();
  var imagePath;
  var formKey = GlobalKey<FormState>();
  late NotesProvider provider;
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();
    recorder.init();
  }

  @override
  void dispose() {
    super.dispose();
    recorder.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var arguments = ModalRoute.of(context)!.settings.arguments;

    provider = Provider.of(context);
    final isRecording = recorder.isRecording;
    final icon = isRecording ? Icons.stop : Icons.mic;
    final primary = isRecording ? Colors.red : Colors.grey;
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
                'Note Name',
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
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: Column(
              children: [
                Expanded(
                  child: notes.messages.length > 1
                      ? ListView.builder(
                          itemBuilder: (context, index) {
                            return MessageItem(index + 1);
                          },
                          itemCount: notes.messages.length - 1,
                        )
                      : Center(child: SizedBox()),
                ),
                SizedBox(
                  height: 15,
                ),
                Form(
                  key: formKey,
                  child: Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: myController,
                          onChanged: (text) {
                            message = text;
                          },
                          decoration: InputDecoration(
                            hintText: 'Type Your Message: ',
                            // focusedBorder:  OutlineInputBorder(
                            //   borderRadius: BorderRadius.only(topRight: Radius.circular(20)),
                            //   borderSide: BorderSide(color: Colors.grey)
                            // ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20)),
                                borderSide: BorderSide(color: Colors.grey)),
                            suffixIcon: IconButton(
                              onPressed: () async {
                                final isRecording =
                                    await recorder.toggleRecording();
                                setState(() {});
                              },
                              icon: Icon(
                                icon,
                                color: primary,
                              ),
                            ),
                            prefixIcon: IconButton(
                              onPressed: () {
                                getImage();
                              },
                              icon: Icon(
                                Icons.attach_file_outlined,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'Please Enter a Message';
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20)))),
                        onPressed: () {
                          if (formKey.currentState!.validate() == true) {
                            DataUtils n = DataUtils();
                            notes.messages.add({'message': message});
                            notes.time.add({
                              'time': DateFormat('MM/dd/yyyy \n hh:mm a')
                                  .format(DateTime.now())
                                  .toString()
                            });
                            n.updateMessages(notes);

                            provider.refreshMessages();
                            myController.clear();
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Text(
                                'Send',
                                style: TextStyle(fontSize: 15),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(Icons.send)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future getImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? imagePicked =
        await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imagePath = imagePicked!.path;
    });
  }
}
