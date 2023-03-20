import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_exam/state%20management/auth_manager.dart';
import 'package:map_exam/state%20management/notes_manager.dart';

import '../model/note.dart';
import '../widgets/note_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final noteManager = Get.put(NotesManager());
  AuthManager authManager = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
        actions: [
          CircleAvatar(
              backgroundColor: Colors.blue.shade200,
              child: StreamBuilder<List<Note>>(
                stream: noteManager.getUsersNotes(authManager.loggedInUserId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final notes = snapshot.data;

                    return Text(
                      '${notes!.length}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 22.0),
                    );
                  } else if (snapshot.hasError) {
                    return const Text(
                      '0',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 22.0),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              )),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: StreamBuilder<List<Note>>(
        stream: noteManager.getUsersNotes(authManager.loggedInUserId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final notes = snapshot.data;

            return ListView.separated(
              itemCount: snapshot.data!.length,
              separatorBuilder: (context, index) => const Divider(
                color: Colors.blueGrey,
              ),
              itemBuilder: (context, index) => NoteTile(
                note: notes![index],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Obx(
            () => FloatingActionButton(
                child: noteManager.isExpanded.value
                    ? const Icon(Icons.unfold_less)
                    : const Icon(Icons.menu),
                tooltip: 'Show less. Hide notes content',
                onPressed: () => noteManager.expandNotes()),
          ),

          /* Notes: for the "Show More" icon use: Icons.menu */

          FloatingActionButton(
            child: const Icon(Icons.add),
            tooltip: 'Add a new note',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
