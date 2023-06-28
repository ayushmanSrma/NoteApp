import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_app/model/note_data.dart';
import 'package:provider/provider.dart';
import '../model/note.dart';
import 'edit_note_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<NoteData>(context, listen: false).initialiseList();
  }

  //create new note
  void createNewNote() {
    //create new id
    int id = Provider.of<NoteData>(context, listen: false).getAllNotes().length;
    //create a blank note
    Note newNote = Note(
      id: id,
      text: "",
    );
    // go to edit note
    goToNotePage(newNote, true);
  }

  //go to the note editing page
  void goToNotePage(Note note, bool isNewNote) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditingNotePage(note: note, isNewNote: isNewNote),
      ),
    );
  }

  //delete note
  void deleteNote(Note note) {
    Provider.of<NoteData>(context, listen: false).deleteNode(note);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: CupertinoColors.systemGroupedBackground,
        floatingActionButton: FloatingActionButton(
          onPressed: createNewNote,
          elevation: 0,
          backgroundColor: Colors.grey[300],
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 75, right: 150, bottom: 10),
                child: Text(
                  'Notes',
                  style: TextStyle(
                      letterSpacing: 1,
                      fontWeight: FontWeight.w800,
                      fontSize: 40,
                      fontFamily: 'AppleFont'),
                ),
              ),

              //list of notes
              value.getAllNotes().length == 0
                  ? Center(
                      child: Text(
                        'Nothing Here',
                        style: TextStyle(
                            fontFamily: "AppleFont", color: Colors.grey),
                      ),
                    )
                  : CupertinoListSection.insetGrouped(
                      children: List.generate(
                        value.getAllNotes().length,
                        (index) => CupertinoListTile(
                          title: Text(value.getAllNotes()[index].text),
                          onTap: () =>
                              goToNotePage(value.getAllNotes()[index], false),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: (){
                              deleteNote(value.getAllNotes()[index]);
                            },
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
