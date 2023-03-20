import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:map_exam/model/note.dart';

class NotesManager extends GetxController {
  // final FireStoreData _fireStoreData = FireStoreData();

  var isExpanded = false.obs;

  expandNotes() {
    isExpanded(!isExpanded.value);
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
