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
  void addNewNote() {
    //get new id
    int id = Provider.of<NoteData>(context,listen: false).getAllNotes().length;
    //get text from editor
    String text = _controller.document.toPlainText();
    //add the new node
    Provider.of<NoteData>(context, listen: false)
        .addNewNote(Note(id: id, text: text));
  }

  //updating existing note
  void updateNote(){
    //get text from editor
    String text = _controller.document.toPlainText();
    //update note
    Provider.of<NoteData>(context,listen: false).updateNote(widget.note, text);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          color: Colors.black,
            onPressed: (){
              //if it is a new note??
              if(widget.isNewNote && !_controller.document.isEmpty()){
                addNewNote();
              }else{
                updateNote();
              }
              Navigator.pop(context);

              //if not new note
            },
            icon: Icon(Icons.arrow_back_ios)
        ),
      ),
      body: Column(children: [
        //toolbar
        SafeArea(
          child: QuillToolbar.basic(controller: _controller,
          showAlignmentButtons: false,
            showBackgroundColorButton: false,
            showBoldButton: false,
            showCenterAlignment: false,
            showClearFormat: false,
            showCodeBlock: false,
            showColorButton: false,
            showDirection: false,
            showDividers: false,
            showFontFamily: false,
            showFontSize: false,
            showHeaderStyle: false,
            showIndent: false,
            showInlineCode: false,
            showItalicButton: false,
            showJustifyAlignment: false,
            showLeftAlignment: false,
            showLink: false,
            showListBullets: false,
            showListCheck: false,
            showListNumbers: false,
            showQuote: false,
            showRightAlignment: false,
            showStrikeThrough: false,
            showSuperscript: false,
            showSmallButton: false,
            showSubscript: false,
            showUnderLineButton: false,



          ),
        ),
        //editor
        Expanded(child: Container(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: QuillEditor.basic(
                controller: _controller,
                readOnly: false
            ),
          ),
        ))
      ],),
    );
  }
}
