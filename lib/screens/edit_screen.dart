import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_exam/state%20management/auth_manager.dart';
import 'package:map_exam/state%20management/notes_manager.dart';
import 'package:map_exam/utils/enum.dart';

import '../model/note.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({Key? key, required this.modeType, this.note})
      : super(key: key);
  final EditMode modeType;
  final Note? note;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  NotesManager notesManager = Get.find();
  AuthManager authManager = Get.find();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  late bool showOneAction;
  late String appbarTitle;

  @override
  void initState() {
    super.initState();

    _titleController.text = widget.note?.title ?? '';
    _descriptionController.text = widget.note?.content ?? '';
    showOneAction = widget.modeType != EditMode.view;

    switch (widget.modeType) {
      case EditMode.view:
        appbarTitle = 'View Note';
        break;
      case EditMode.edit:
        appbarTitle = 'Edit Note';
        break;
      case EditMode.add:
        appbarTitle = 'Add new Note';
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        centerTitle: true,
        title: Text(appbarTitle),
        actions: [
          if (showOneAction)
            IconButton(
                icon: const Icon(
                  Icons.check_circle,
                  size: 30,
                ),
                onPressed: () {
                  if (widget.modeType == EditMode.edit) {
                    final note = Note.fromJson({
                      'id': widget.note?.id,
                      'title': _titleController.text,
                      'content': _descriptionController.text
                    });
                    notesManager.editANote(note, authManager.loggedInUserId);
                    notesManager.showEditingTool(0);
                    Get.back();
                  } else {
                    final note = Note.fromJson({
                      'id': notesManager.itemsNumber + 1,
                      'title': _titleController.text,
                      'content': _descriptionController.text
                    });
                    notesManager.addANote(note, authManager.loggedInUserId);
                    notesManager.showEditingTool(0);
                    Get.back();
                  }
                }),
          IconButton(
              icon: const Icon(
                Icons.cancel_sharp,
                size: 30,
              ),
              onPressed: () {
                Get.back();
              }),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              initialValue: null,
              enabled: widget.modeType != EditMode.view,
              readOnly: widget.modeType == EditMode.view,
              decoration: const InputDecoration(
                hintText: 'Type the title here',
              ),
              onChanged: (value) {},
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: TextFormField(
                  controller: _descriptionController,
                  enabled: widget.modeType != EditMode.view,
                  readOnly: widget.modeType == EditMode.view,
                  initialValue: null,
                  maxLines: null,
                  expands: true,
                  decoration: const InputDecoration(
                    hintText: 'Type the description',
                  ),
                  onChanged: (value) {}),
            ),
          ],
        ),
      ),
    );
  }
}
