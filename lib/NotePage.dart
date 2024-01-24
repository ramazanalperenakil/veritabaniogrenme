import 'package:flutter/material.dart';
import 'Models/note_model.dart';
import 'database_helper.dart';

class NotePage extends StatefulWidget {
  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  late DatabaseHelper dbHelper;
  late List<Note> notes;

  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper();
    notes = []; // notes değişkenini başlat
    refreshNotes();
  }

  Future<void> refreshNotes() async {
    List<Note> _notes = await dbHelper.getAllNotes();
    setState(() {
      notes = _notes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notlar'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(notes[index].title),
              subtitle: Text(notes[index].content),
              onTap: () {
                // Note'u güncelleme sayfasına git
                _navigateToEditPage(notes[index]);
              },
              onLongPress: () {
                // Note'u sil
                _deleteNoteDialog(notes[index].id!);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Yeni bir not ekleme sayfasına git
          _navigateToEditPage(null);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _navigateToEditPage(Note? note) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditNotePage(note: note, dbHelper: dbHelper),
      ),
    );

    // Sayfa geri döndüğünde notları güncelle
    refreshNotes();
  }

  Future<void> _deleteNoteDialog(int noteId) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Sil'),
          content: Text('Silmek İstediğinize Emin Misiniz?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Vazgeç'),
            ),
            TextButton(
              onPressed: () async {
                await dbHelper.deleteNote(noteId);
                Navigator.of(context).pop();
                refreshNotes();
              },
              child: Text('Sil'),
            ),
          ],
        );
      },
    );
  }
}

class EditNotePage extends StatefulWidget {
  final Note? note;
  final DatabaseHelper dbHelper;

  EditNotePage({Key? key, required this.dbHelper, this.note}) : super(key: key);

  @override
  _EditNotePageState createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note?.title ?? '');
    _contentController =
        TextEditingController(text: widget.note?.content ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Düznle'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Başlık'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(labelText: 'İçerik'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                Note newNote = Note(
                  id: widget.note?.id,
                  title: _titleController.text,
                  content: _contentController.text,
                );

                if (widget.note == null) {
                  // Yeni not ekliyorsa
                  await widget.dbHelper.insertNote(newNote);
                } else {
                  // Var olan notu güncelliyorsa
                  await widget.dbHelper.updateNote(newNote);
                }

                Navigator.of(context).pop();
              },
              child: Text('Kaydet'),
            ),
          ],
        ),
      ),
    );
  }
}
