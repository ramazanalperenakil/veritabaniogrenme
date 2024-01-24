import 'package:flutter/material.dart';
import 'Models/note_model.dart';
import 'database_helper.dart';

class AddNotePage extends StatefulWidget {
  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  // Controller for handling user input
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  // Database helper instance
  DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Not Ekle'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Note Title
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Başlık'),
            ),
            SizedBox(height: 16.0),

            // Note Content
            TextField(
              controller: contentController,
              decoration: InputDecoration(labelText: 'İçerik'),
              maxLines: 4,
            ),
            SizedBox(height: 16.0),

            // Add Note Button
            ElevatedButton(
              onPressed: () async {
                // Create a Note object from user input
                Note newNote = Note(
                  title: titleController.text,
                  content: contentController.text,
                  //time: DateTime.now().toString(),
                );

                // Insert the note into the database
                await databaseHelper.insertNote(newNote);

                // Navigate back to the previous screen
                Navigator.pop(context);
              },
              child: Text('Kaydet'),
            ),
          ],
        ),
      ),
    );
  }
}
