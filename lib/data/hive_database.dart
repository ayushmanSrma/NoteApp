import 'package:hive/hive.dart';

import '../model/note.dart';

class HiveDatabase{
  //reference our
  final _mybox = Hive.box('note_database');

  //load our data
List<Note> loadNotes(){
  List<Note> savedNotesFormatted = [];

  //if there is note return that,otherwise return empty note
  if (_mybox.get('All_Notes') != null){
    List<dynamic> savedNotes = _mybox.get('All_Notes');
    for(int i=0;i<savedNotes.length;i++){
      //create individual note
      Note individualNote = Note(id: savedNotes[i][0], text: savedNotes[i][1]);
      //add to list
      savedNotesFormatted.add(individualNote);
    }
  }else{
    //default First Note
   savedNotesFormatted.add(Note(id: 0,text: 'First Note'));
  }
  return savedNotesFormatted;
}

  //save our data
  void savedNotes(List<Note> allNote){
  List<List<dynamic>> allNotesFormatted =[
  /*
  save note format
  [
  [0,first note]
  [1,second note]
  ]

   */
    ];

  for(var note in allNote){
    int id = note.id;
    String text = note.text;
    allNotesFormatted.add([id,text]);
  }
  //then store in the hive
    _mybox.put('All_Notes',allNotesFormatted);
  }
}