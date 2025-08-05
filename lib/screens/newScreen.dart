import 'package:flutter/material.dart';
import 'package:notepad_ocean/models/note.dart';

import '../services/noteService.dart';

class NewNote extends StatefulWidget {
  const NewNote({super.key});

  @override
  State<NewNote> createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {

  Color _backgroundColor = Color(0xffFFF3E0);

  void _changeBackground(Color newColor) {
    setState(() {
      _backgroundColor = newColor;
    });
  }

  Note note = Note(title: "title", content: " ");

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  late FocusNode _contentFocusNode;

  bool _isContentFieldFocused = false;

  @override
  void initState() {
    super.initState();
    _contentFocusNode = FocusNode();
    // Add a listener to the focus node to update our state
    _contentFocusNode.addListener(_onContentFocusChanged);
  }

  void _onContentFocusChanged() {
    setState(() {
      _isContentFieldFocused = _contentFocusNode.hasFocus;
    });
  }

  void _saveNote() async {
    final String title = _titleController.text.trim();
    final String content = _contentController.text.trim();

    if (title.isEmpty && content.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Note cannot be empty!')));
      return;
    }

    final newNote = Note(
      title: title.isNotEmpty ? title : 'Untitled Note',
      content: content,
    );

    // Save the new note using the NoteService
    await NoteService.instance.saveNote(newNote);

    // Pop the screen after saving
    Navigator.pop(context);
  }

  @override
  void dispose() {
    // Dispose controllers and focus node to prevent memory leaks
    _titleController.dispose();
    _contentController.dispose();
    _contentFocusNode.removeListener(_onContentFocusChanged); // Remove listener
    _contentFocusNode.dispose(); // Dispose focus node
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    const double bottomBarHeight = 60.0;

    return SafeArea(
        child:
          Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: _backgroundColor,
            body: SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 60,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 7),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Image.asset(
                          "assets/images/back_icon.png",
                          width: 25,
                          height: 20,
                        ),
                      ),
                      SizedBox(width: 10),
                      Padding(
                        padding: const EdgeInsets.only(top: 9.0),
                        child: SizedBox(
                          height: 35,
                          width: 200,
                          child: TextField(
                            maxLines: 1,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              hintText: "Note title",
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                              ),
                            ),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextField(
                    controller: _contentController,
                    focusNode: _contentFocusNode,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    expands: false,
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      hintText: "Content",
                      contentPadding: EdgeInsetsGeometry.only(left: 17),
                      hintStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey,
                      ),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom,),
              child: BottomAppBar(
                color: Colors.blueGrey,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => _changeBackground(Color(0xffE3F2FD)),
                      child: Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                            color: Color(0xffE3F2FD),
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    GestureDetector(
                      onTap: () => _changeBackground(Color(0xffFBE9E7)),
                      child: Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffFBE9E7),
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    GestureDetector(
                      onTap: () => _changeBackground(Color(0xffC5E1A5)),
                      child: Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffC5E1A5),
                        ),
                      ),
                    ),
                    SizedBox(width: 70,),
                    ElevatedButton(onPressed: (){}, child: Text("Save"))
                  ],
                ),
              ),
            ),
          ),
    );
  }
}
