import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_exam/state%20management/notes_manager.dart';

import '../model/note.dart';

class NoteTile extends StatelessWidget {
  NoteTile({
    Key? key,
    required this.note,
    required this.tileIndex,
  }) : super(key: key);
  final Note note;

  final NotesManager noteManager = Get.find();
  int tileIndex;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListTile(
        trailing: SizedBox(
          width: 110.0,
          child: noteManager.showEditingTools.value == (tileIndex + 1)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.blue,
                      ),
                      onPressed: () {},
                    ),
                  ],
                )
              : null,
        ),
        title: Text(note.title!),
        subtitle:
            noteManager.notesAreExpanded.value ? Text(note.content!) : null,
        onTap: () {},
        onLongPress: () {
          if (noteManager.showEditingTools.value != (tileIndex + 1)) {
            noteManager.showEditingTool(tileIndex + 1);
          } else {
            noteManager.showEditingTool(0);
          }
        },
      ),
    );
  }
}
