import 'package:flutter/foundation.dart';
import 'package:note_app/data/hive_database.dart';

import 'note.dart';

class NoteData extends ChangeNotifier {
  //hive database
  final db = HiveDatabase();

  //overall list of notes
  List<Note> allNotes = [
    //default first note
  ];

  //initialising the list
  void initialiseList(){
    allNotes = db.loadNotes();
  }

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
    notifyListeners();
  }
}