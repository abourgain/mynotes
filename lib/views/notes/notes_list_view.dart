import 'package:flutter/material.dart';
import '../../services/crud/notes_service.dart';
import '../../utilities/dialogs/delete_dialog.dart';

typedef DeleteNoteCallback = void Function(DatabaseNote note);

class NotesListView extends StatelessWidget {
  final List<DatabaseNote> notes;
  final DeleteNoteCallback onDeleteNote;

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
        return Dismissible(
          key: Key(note.id.toString()),
          onDismissed: (direction) async {
            onDeleteNote(note);
            // Then show a snackbar.
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Note dismissed')));
          },
          // Show a red background as the item is swiped away.
          background: Container(color: Colors.red),
          child: ListTile(
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
