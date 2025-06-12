import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ghj/services/auth/crud/cloud/cloud_note.dart';
import 'package:ghj/services/auth/crud/cloud/cloud_storage_constants.dart';
import 'package:ghj/services/auth/crud/cloud/cloud_storage_exceptions.dart';

class FirebaseCloudStorage {
  final notes = FirebaseFirestore.instance.collection('notes');

  Future<void> updateNote({
    required String documentId,
    required String text,
  }) async {
    try {
      await notes.doc(documentId).update({textFieldName: text});
    } catch (e) {
      throw CouldNotUpdateNoteException();
    }
  }

  Future<void> deleteNote({
    required String documentId,
    required String text,
  }) async {
    try {
      await notes.doc(documentId).delete();
    } catch (e) {
      throw CouldNotDeleteNoteException();
    }
  }

  Stream<Iterable<CloudNote>> allNotes({required String ownerUserId}) =>
      notes.snapshots().map(
        (event) => event.docs
            .map((doc) => CloudNote.fromSnapshot(doc))
            .where((note) => note.ownerUserId == ownerUserId),
      );

  void createNewNote({required String ownerUserID}) async {
    await notes.add({ownerUserIdFieldName: ownerUserID, textFieldName: ''});
  }

  Future<Iterable<CloudNote>> getNotes({required String ownerUserID}) async {
    try {
      return await notes
          .where(ownerUserIdFieldName, isEqualTo: ownerUserID)
          .get()
          .then(
            (value) => value.docs.map((doc) {
              return CloudNote(
                documentId: doc.id,
                ownerUserId: doc.data()[ownerUserIdFieldName] as String,
                text: doc.data()[textFieldName] as String,
              );
            }),
          );
    } catch (e) {
      throw CouldNotGetAllNotesException();
    }
  }

  static final FirebaseCloudStorage _shared =
      FirebaseCloudStorage._sharedInstance();
  FirebaseCloudStorage._sharedInstance();
  factory FirebaseCloudStorage() => _shared;
}
