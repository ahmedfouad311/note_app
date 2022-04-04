import 'package:flutter/material.dart';
import 'package:note_app/Data/data_utils.dart';
import 'package:note_app/Data/notes_model.dart';

class NotesProvider extends ChangeNotifier {
  DataUtils n = DataUtils();
  List<NotesModel> items = [];
  refreshData({required List<NotesModel> input}) async {
    items = input;
    notifyListeners();
  }

  refreshMessages() async {
    // items = await n.getMessages();
    notifyListeners();
  }

  clearData() {
    items.clear();
    notifyListeners();
  }
}
