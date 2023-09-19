import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/models/note_data.dart';
import 'package:provider/provider.dart';

import 'note_edit_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  // on save note
  void saveNote(){
    int id = Provider.of<NoteData>(context,listen: false).getNotesList().length;

    Note note = Note(id: id, text: '');

    // go into the edit page 
    goToEditPage(note,true);
  }

  // route for edit page
  void goToEditPage(Note note,bool isNewNote){
    Navigator.push(context, MaterialPageRoute(builder: (context) => NoteEditPage(note:note, isNewNote:isNewNote),));
  }

  // dlete note
  void deleteNote(Note note){
    Provider.of<NoteData>(context,listen: false).deleteNote(note);
  }



  @override
  Widget build(BuildContext context) {
    return Consumer<NoteData>(
      builder: (context, value, child) => Scaffold(
        // appBar: AppBar(),
        backgroundColor: CupertinoColors.systemGroupedBackground,
        body: Column(  
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 25.0,top: 75),
              child: Text('Notes App',
                style: TextStyle(  
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            CupertinoListSection.insetGrouped(
              children: List.generate(value.getNotesList().length,
               (index) => 
               CupertinoListSection.insetGrouped(  
                children: [
                  CupertinoListTile(
                    title: Text(value.getNotesList()[index].text),
                    trailing: IconButton(  
                      onPressed: () => deleteNote(value.getNotesList()[index]),
                      icon: Icon(Icons.delete,color: Colors.grey[400],),
                    ),
                  )
                ],
               )
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(  
          backgroundColor: Colors.grey[400],
          onPressed: saveNote,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}