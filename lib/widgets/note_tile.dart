import 'package:flutter/material.dart';

import '../model/note.dart';

class NoteTile extends StatelessWidget {
  const NoteTile({
    Key? key,
    required this.note,
  }) : super(key: key);
  final Note note;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: SizedBox(
        width: 110.0,
        child: Row(
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
        ),
      ),
      title: Text(note.title!),
      subtitle: Text(note.content!),
      onTap: () {},
      onLongPress: () {},
    );
  }
}
