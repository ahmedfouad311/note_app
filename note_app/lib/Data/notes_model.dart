import 'dart:convert';

class NotesModel {
  String noteTitle;
  String description;
  List<Map<String, dynamic>> messages;
  List<Map<String, dynamic>> time;
   int id;

  NotesModel(
      { required this.id,
        required this.noteTitle,
      required this.description,
      required this.messages,
      required this.time});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': noteTitle,
      'description': description,
      'messages': jsonEncode(messages),
      'time': jsonEncode(time),
    };
  }
}
