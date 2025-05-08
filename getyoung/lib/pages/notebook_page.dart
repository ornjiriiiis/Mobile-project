import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'notes_page.dart';
import 'home_page.dart';

class NotebookPage extends StatefulWidget {
  @override
  _NotebookPageState createState() => _NotebookPageState();
}

class _NotebookPageState extends State<NotebookPage> {
  List<String> myNotes = [];

  @override
  void initState() {
    super.initState();
    loadSavedNotes();
  }

  Future<void> loadSavedNotes() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      myNotes = prefs.getStringList('savedNotes') ?? [];
    });
  }

  Future<void> saveNotesToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('savedNotes', myNotes);
  }

  Future<void> addCustomNote() async {
    final TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("New Notebook"),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: "Notebook name"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              if (controller.text.isNotEmpty && !myNotes.contains(controller.text)) {
                setState(() {
                  myNotes.add(controller.text);
                });
                await saveNotesToPrefs();
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("${controller.text} is added!")),
                );
              }
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }

  Future<void> deleteNote(String name) async {
    setState(() {
      myNotes.remove(name);
    });
    await saveNotesToPrefs();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("$name is deleted.")),
    );
  }

  Widget buildFolder(String label) {
    return Card(
      elevation: 3,
      color: Colors.yellow[50],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(Icons.folder, color: Colors.amber),
        title: Text(label),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.redAccent),
          onPressed: () => deleteNote(label),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF68169),
        title: Text('My Notebook', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => NotesPage()));
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: myNotes.isEmpty
          ? Center(child: Text("No notebooks saved yet."))
          : ListView.builder(
              padding: EdgeInsets.all(12),
              itemCount: myNotes.length,
              itemBuilder: (context, index) => buildFolder(myNotes[index]),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: addCustomNote,
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.black,
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFFF68169),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(icon: Icon(Icons.home, color: Colors.white, size: 30), onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
              }),
            IconButton(icon: Icon(Icons.people, color: Colors.white, size: 30), onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => NotesPage()));
              }),
            IconButton(icon: Icon(Icons.book, color: Colors.white, size: 30), onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => NotebookPage()));
              }),
            ],
          ),
      ),
    );
  }
}
