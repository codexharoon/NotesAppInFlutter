import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/models/note_data.dart';
import 'package:provider/provider.dart';

class NoteEditPage extends StatefulWidget {
  final Note note;
  final bool isNewNote;

  const NoteEditPage({
    Key? key,
    required this.note,
    required this.isNewNote,
  }) : super(key: key);

  @override
  State<NoteEditPage> createState() => _NoteEditPageState();
}

class _NoteEditPageState extends State<NoteEditPage> {

  QuillController controller = QuillController.basic();

  @override
  void initState() {
    loadExistingNote();
    super.initState();
  }

  // load existing note
  void loadExistingNote(){
    final doc = Document()..insert(0, widget.note.text);

    setState(() {
      controller = QuillController(document: doc,selection: const TextSelection.collapsed(offset: 0));
    });
  }

  // add new note
  void newNote(){
    int id = Provider.of<NoteData>(context,listen: false).getNotesList().length;
    String text = controller.document.toPlainText();

    Provider.of<NoteData>(context,listen: false).addNote(Note(id: id, text: text));
  }

  // update note
  void updateNote(){
    String text = controller.document.toPlainText();
    Provider.of<NoteData>(context,listen: false).updateNote(widget.note, text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.close,color: Colors.grey,),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
                  // if its new note so add it
                  if(widget.isNewNote && !controller.document.isEmpty()){
                    newNote();
                    Navigator.of(context).pop();
                  }
                  //update the note
                  else{
                    updateNote();
                    Navigator.of(context).pop();
                  }
                },
              icon: const Icon(Icons.check,color: Colors.grey,)
          )
        ],
      ),
      body: Column(  
        children: [
          // toolbar
          QuillToolbar.basic(
            controller: controller,
            showCodeBlock: false,
            iconTheme: const QuillIconTheme(iconSelectedFillColor: Colors.grey),
          ),

          //editor
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: QuillEditor.basic(controller: controller, readOnly: false),
            )
          ),
        ],
      ),
    );
  }
}