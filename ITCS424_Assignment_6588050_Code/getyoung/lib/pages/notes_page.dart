import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';
import 'notebook_page.dart';

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  List<String> folders = [
    'Notebook 1 (Math)',
    'Notebook 2 (Bio)',
    'Notebook 3 (English)',
    'Notebook 4 (Physics)',
    'Notebook 5 (Chemistry)',
    'Notebook 6 (History)',
    'Notebook 7 (Geography)',
    'Notebook 8 (Computer Science)'
  ];

  Future<void> saveNote(String name) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> savedNotes = prefs.getStringList('savedNotes') ?? [];

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Save Note"),
        content: Text("Do you want to save \"$name\" to your notebook?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              if (!savedNotes.contains(name)) {
                savedNotes.add(name);
                await prefs.setStringList('savedNotes', savedNotes);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('$name saved successfully!')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('$name is already saved.')),
                );
              }
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF68169),
        title: Text("Notes Community", style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search subjects...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                ...folders.map(
                  (folder) => ListTile(
                    leading: Icon(Icons.folder, color: Colors.amber),
                    title: Text(folder),
                    onTap: () => saveNote(folder),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
              ),
              icon: Icon(Icons.book),
              label: Text("Go to My Notebook"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => NotebookPage()),
                );
              },
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFFF68169),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
              },
            ),
            IconButton(
              icon: Icon(Icons.people, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => NotesPage()));
              },
            ),
            IconButton(
              icon: Icon(Icons.book, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => NotebookPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
