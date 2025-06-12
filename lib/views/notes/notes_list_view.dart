import 'package:flutter/material.dart';
import 'package:ghj/services/auth/crud/notes_service.dart';
import 'package:ghj/utilities/dialogs/delete_dialog.dart' ;
typedef DeleteNoteCallback = void Function(DatabaseNote note);

class NotesListView extends StatelessWidget {
  final DeleteNoteCallback onDeleteNote;
  final List<DatabaseNote> notes;

  const NotesListView({
    Key? key,
    required this.notes,
    required this.onDeleteNote,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes[index];
        return ListTile(
          title: Text(
            note.text,
            maxLines: 1,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: IconButton(
            onPressed: () async {
              final shouldDelete = await showDeleteDialog(context) ;
              if(shouldDelete) {
               onDeleteNote(note) ;
              }
            },
            icon: Icon(Icons.delete),
          ),
        );
      },
    );
  }
}
