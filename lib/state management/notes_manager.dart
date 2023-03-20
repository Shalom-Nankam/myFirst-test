import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:map_exam/model/note.dart';

class NotesManager extends GetxController {
  // final FireStoreData _fireStoreData = FireStoreData();

  var notesAreExpanded = false.obs;
  var showEditingTools = 0.obs;

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
}
