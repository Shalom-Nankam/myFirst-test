import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_exam/screens/edit_screen.dart';
import 'package:map_exam/state%20management/auth_manager.dart';
import 'package:map_exam/state%20management/notes_manager.dart';
import 'package:map_exam/utils/enum.dart';

import '../model/note.dart';

class NoteTile extends StatelessWidget {
  NoteTile({
    Key? key,
    required this.note,
    required this.tileIndex,
  }) : super(key: key);
  final Note note;

  final NotesManager noteManager = Get.find();
  final AuthManager authManager = Get.find();
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
                      onPressed: () {
                        Get.to(() => EditScreen(
                              modeType: EditMode.edit,
                              note: note,
                            ));
                      },
                    ),
                    IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.blue,
                        ),
                        onPressed: () async {
                          await noteManager.deleteANote(
                              note, authManager.loggedInUserId);
                        }),
                  ],
                )
              : null,
        ),
        title: Text(note.title!),
        subtitle:
            noteManager.notesAreExpanded.value ? Text(note.content!) : null,
        onTap: () {
          Get.to(() => EditScreen(
                modeType: EditMode.view,
                note: note,
              ));
        },
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
