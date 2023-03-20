import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreData {
  final _db = FirebaseFirestore.instance;

  Future addNewNote(Map<String, dynamic> note, String userId) async {
    try {
      DocumentReference newDocumentId = await _db
          .collection('users')
          .doc(userId)
          .collection("user_notes")
          .add(note);
      return {"success": true, "message": newDocumentId.id};
    } on FirebaseException catch (e) {
      return {"success": false, "message": e.message};
    }
  }

  Future editNote(
      Map<String, dynamic> note, String userId, String documentID) async {
    try {
      await _db
          .collection('users')
          .doc(userId)
          .collection("user_notes")
          .doc(documentID)
          .update(note);
      return true;
    } on FirebaseException {
      return false;
    }
  }

  Future deleteNote(String userId, String documentID) async {
    try {
      await _db
          .collection('users')
          .doc(userId)
          .collection("user_notes")
          .doc(documentID)
          .delete();
      return true;
    } on FirebaseException {
      return false;
    }
  }
}
