import 'package:flutter/material.dart';
import 'package:mynotes/services/cloud/cloud_note.dart';
import '../../services/crud/notes_service.dart';
import '../../utilities/dialogs/delete_dialog.dart';

typedef NoteCallback = void Function(CloudNote note);

class NotesListView extends StatelessWidget {
  final Iterable<CloudNote> notes;
  final NoteCallback onDeleteNote;
  final NoteCallback onTap;

  const NotesListView({
    Key? key,
    required this.notes,
    required this.onDeleteNote,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      shrinkWrap: true,
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes.elementAt(index);
        return Dismissible(
          key: Key(note.documentId.toString()),
          onDismissed: (direction) async {
            onDeleteNote(note);
            // Then show a snackbar.
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Note dismissed')));
          },
          // Show a red background as the item is swiped away.
          background: Container(color: Colors.red),
          child: ListTile(
            onTap: () {
              onTap(note);
            },
            title: Text(
              note.text,
              maxLines: 1,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: IconButton(
              onPressed: () async {
                final shouldDelete = await showDeleteDialog(context);
                if (shouldDelete) {
                  onDeleteNote(note);
                  // Then show a snackbar.
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Note dismissed')));
                }
              },
              icon: const Icon(Icons.delete),
            ),
          ),
        );
      },
    );
  }
}
