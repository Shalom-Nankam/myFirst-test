import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:map_exam/model/note.dart';

import '../services/database/firestore_database.dart';

class NotesManager extends GetxController {
  final FireStoreData _fireStoreData = FireStoreData();

  var notesAreExpanded = false.obs;
  var showEditingTools = 0.obs;
  int itemsNumber = 0;

  expandNotes() {
    notesAreExpanded(!notesAreExpanded.value);
  }

  showEditingTool(int number) {
    showEditingTools(number);
  }

  Stream<List<Note>> getUsersNotes(String userId) {
    return FirebaseFirestore.instance
        .collection('notes')
        .doc(userId)
        .collection("user_notes")
        .snapshots()
        .map(
            (event) => event.docs.map((e) => Note.fromJson(e.data())).toList());
  }

  void getStreamItemsNumber(int streamData) {
    itemsNumber = streamData;
  }

  deleteANote(Note note, String userId) async {
    final hasDeleted = await _fireStoreData.deleteNote(userId, note);
    if (hasDeleted) {}
  }

  editANote(Note note, String userId) async {
    final hasDeleted = await _fireStoreData.editNote(note, userId);
    if (hasDeleted) {}
  }

  addANote(Note note, String userId) async {
    final hasDeleted = await _fireStoreData.addNewNote(note, userId);
    if (hasDeleted) {}
  }
}
