import 'package:flutter/material.dart';
import 'package:notepad_ocean/screens/newScreen.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.blueGrey),
      body: Column(
        children: [
          SizedBox(height: 160),
          Image.asset("assets/images/notepad.png", width: 100, height: 100),
          Center(
            child: Text(
              "No notes yet",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          SizedBox(height: 30),
          Center(
            child: Text(
              "Tap the + button to create your first note",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: 150),
          Padding(
            padding: const EdgeInsets.only(left: 170.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NewNote()),
                );
              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(100, 70),
                elevation: 20,
                side: BorderSide(color: Colors.blueGrey, width: 1)
              ),
              child: Icon(Icons.add, size: 40, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}

