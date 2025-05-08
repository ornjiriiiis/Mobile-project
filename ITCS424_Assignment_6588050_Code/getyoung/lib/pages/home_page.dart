import 'package:flutter/material.dart';
import 'notebook_page.dart';
import 'notes_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF68169),
        title: Text('Welcome Ornjira!', style: TextStyle(color: Colors.white)),
        leading: Icon(Icons.person, color: Colors.white),
        actions: [
          IconButton(icon: Icon(Icons.notifications, color: Colors.white),onPressed: () {},),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            menuButton('Q&A'),
            menuButton('Quiz'),
            menuButton('Notes', onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => NotesPage()));
            }),
            menuButton('Learn Together'),
          ],
        ),
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

  Widget menuButton(String label, {VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ElevatedButton(
        onPressed: onTap,
        child: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange[100],
          foregroundColor: Colors.black,
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        ),
      ),
    );
  }
}
