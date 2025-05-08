import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(NotesCommunityApp());
}

class NotesCommunityApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes Community',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
