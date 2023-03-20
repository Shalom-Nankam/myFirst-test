import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_exam/state%20management/notes_manager.dart';

import '../model/note.dart';

class NoteTile extends StatelessWidget {
  NoteTile({
    Key? key,
    required this.note,
  }) : super(key: key);
  final Note note;
  NotesManager noteManager = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListTile(
        trailing: SizedBox(
          width: 110.0,
          child: noteManager.isExpanded.value
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
        subtitle: noteManager.isExpanded.value ? Text(note.content!) : null,
        onTap: () {},
        onLongPress: () {},
      ),
    );
  }
}
