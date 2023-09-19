import 'package:flutter/material.dart';
import 'package:notes_app/models/note.dart';

class NoteEditPage extends StatefulWidget {
  Note note;
  bool isNewNote;

  NoteEditPage({
    Key? key,
    required this.note,
    required this.isNewNote,
  }) : super(key: key);

  @override
  State<NoteEditPage> createState() => _NoteEditPageState();
}

class _NoteEditPageState extends State<NoteEditPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}