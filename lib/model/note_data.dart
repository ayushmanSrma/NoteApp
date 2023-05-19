import 'package:flutter/foundation.dart';

import 'note.dart';

class NoteData extends ChangeNotifier {
  //overall list of notes
  List<Note> allNotes = [
    //default first note
    Note(id: 0, text:"First Note"),
    Note(id: 1, text:"Second Note"),
    Note(id: 2, text:"Third Note"),
  ];

  //get notes

  List<Note> getAllNotes(){
    return allNotes;
  }

  //add a new notes
  void addNewNote(Note note){
    allNotes.add(note);
    notifyListeners();
  }

  //update note
  void updateNote(Note note, String text){
    //go thru list of all the notes
    for(int i= 0;i<allNotes.length;i++){
      //find the relevant note
      if(allNotes[i].id == note.id){
        //replace the text
        allNotes[i].text = text;
      }
    }
    notifyListeners();
  }

  //delete note
  void deleteNode(Note note){
    allNotes.remove(note);
  }
}