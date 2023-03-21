import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:map_exam/model/note.dart';

class FireStoreData {
  final _db = FirebaseFirestore.instance;

  Future addNewNote(Note note, String userId) async {
    final data = note.toJson();
    try {
      await _db
          .collection('notes')
          .doc(userId)
          .collection("user_notes")
          .doc(note.id.toString())
          .set(data);
      return true;
    } on FirebaseException {
      return false;
    }
  }

  Future editNote(
    Note note,
    String userId,
  ) async {
    final data = note.toJson();
    try {
      await _db
          .collection('notes')
          .doc(userId)
          .collection("user_notes")
          .doc(note.id.toString())
          .update(data);
      return true;
    } on FirebaseException {
      return false;
    }
  }

  Future deleteNote(String userId, Note note) async {
    try {
      await _db
          .collection('notes')
          .doc(userId)
          .collection('user_notes')
          .doc('${note.id}')
          .delete();
      return true;
    } on FirebaseException {
      return false;
    }
  }
}
