import 'package:flutter/material.dart';
import 'package:notes_app/models/note.dart';

class NoteData extends ChangeNotifier{

  // list of all notes
  List<Note> allNotes = [
    //raw data
    Note(id: 0, text: 'mynotes'),
    Note(id: 1, text: 'mynotes-2'),
  ];

  // return notes list
  List<Note> getNotesList(){
    return allNotes;
  }

  // add a new note
  void addNote(Note note){
    allNotes.add(note);

    notifyListeners();
  }

  // delete a new note-
  void deleteNote(Note note){
    allNotes.remove(note);

    notifyListeners();
  }


  // update an existing note
  void updateNote(Note note, String text){
    for(int i=0; i<allNotes.length; i++){
      if(allNotes[i].id == note.id){
        allNotes[i].text = text;
      }
    }

    notifyListeners();
  }



}