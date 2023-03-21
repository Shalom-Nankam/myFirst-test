import 'package:flutter/material.dart';
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
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  late bool showBothActions;
  late String appbarTitle;

  @override
  void initState() {
    super.initState();

    _titleController.text = widget.note?.title ?? '';
    _descriptionController.text = widget.note?.content ?? '';
    showBothActions = widget.modeType != EditMode.view;

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
          if (showBothActions)
            IconButton(
                icon: const Icon(
                  Icons.check_circle,
                  size: 30,
                ),
                onPressed: () {}),
          IconButton(
              icon: const Icon(
                Icons.cancel_sharp,
                size: 30,
              ),
              onPressed: () {}),
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
