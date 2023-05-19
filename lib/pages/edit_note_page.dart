import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:note_app/model/note_data.dart';
import 'package:provider/provider.dart';

import '../model/note.dart';

class EditingNotePage extends StatefulWidget {
  Note note;
  bool isNewNote;
  EditingNotePage({super.key, required this.note, required this.isNewNote});

  @override
  State<EditingNotePage> createState() => _EditingNotePageState();
}

class _EditingNotePageState extends State<EditingNotePage> {
  QuillController _controller = QuillController.basic();

  @override
  void initState() {
    super.initState();
    loadExistingNote();
  }

  //load existing note
  void loadExistingNote() {
    final doc = Document()..insert(0, widget.note.text);
    setState(() {
      _controller = QuillController(
          document: doc, selection: const TextSelection.collapsed(offset: 0));
    });
  }

  //add new note
  void addNewNote(int i) {
    //get text from editor
    String text = _controller.document.toPlainText();
    //add the new node
    Provider.of<NoteData>(context, listen: false)
        .addNewNote(Note(id: i, text: text));
  }

  //updating existing note
  void updateNote(){
    //get text from editor
    String text = _controller.document.toPlainText();
    //update nore
    Provider.of<NoteData>(context,listen: false).updateNote(widget.note, text);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
