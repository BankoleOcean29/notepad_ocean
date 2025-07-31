import 'package:flutter/material.dart';
import 'package:notepad_ocean/models/note.dart';

class NewNote extends StatefulWidget {
  const NewNote({super.key});

  @override
  State<NewNote> createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {
  Note note = Note(title: "title", content: " ");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Image.asset(
                        "assets/images/back_icon.png",
                        width: 50,
                        height: 50,
                      ),
                    ),
                    /*SizedBox(
                      width: 35,
                    ),*/
                    SizedBox(
                      height: 40,
                      width: 200,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Note title",
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey
                          ),
                        ),
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
