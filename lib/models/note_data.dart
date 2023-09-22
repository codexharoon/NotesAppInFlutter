import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notes_app/models/note.dart';

class NoteData extends ChangeNotifier{

  // refrence the hive box
  final box = Hive.box('mybox');


  // list of all notes
  List<Note> allNotes = [];

  // return notes list
  List<Note> getNotesList(){
    return allNotes;
  }

  // add a new note
  void addNote(Note note){
    allNotes.add(note);

    saveData();

    notifyListeners();
  }

  // delete a new note-
  void deleteNote(Note note){
    allNotes.remove(note);

    saveData();

    notifyListeners();
  }


  // update an existing note
  void updateNote(Note note, String text){
    for(int i=0; i<allNotes.length; i++){
      if(allNotes[i].id == note.id){
        allNotes[i].text = text;
      }
    }

    saveData();

    notifyListeners();
  }


  //hive methods

  // init method
  void init(){
    if(box.get('noteslist') != null){
      allNotes = getData();
    }
  }

  // save the ddata into database
  void saveData(){  

    // convert the note obj into list
    List<List<String>> notesList = [];

    for(var note in allNotes){
      List<String> singleNoteList = [];

      int id = note.id;
      String text = note.text;

      singleNoteList.addAll(
        [
          id.toString(),
          text
        ]
        );
      
      notesList.add(singleNoteList);
    }

    box.put('noteslist', notesList);
  }


  // get data
  List<Note> getData(){
    var allNotes = box.get('noteslist');

    List<Note> allNotesList = [];

    for(int i=0; i<allNotes.length; i++){
      Note note = Note(id: int.parse(allNotes[i][0]), text: allNotes[i][1]);
      allNotesList.add(note);
    }

    return allNotesList;
  }


}