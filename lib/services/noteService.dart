import 'dart:convert';
import 'package:notepad_ocean/models/note.dart';
import 'package:shared_preferences/shared_preferences.dart';

// A service class to handle CRUD operations for notes using SharedPreferences.
class NoteService {
  // Use a static key for SharedPreferences to store the list of notes.
  static const _notesKey = 'notes_data';

  // Private constructor to prevent instantiation, as this is a singleton-like class.
  NoteService._();

  // Create a singleton instance for easy access throughout the app.
  static final NoteService instance = NoteService._();

  // --- Public methods for note management ---

  /// Retrieves all notes from SharedPreferences.
  Future<List<Note>> getNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final String? notesJsonString = prefs.getString(_notesKey);

    // If there's no data, return an empty list.
    if (notesJsonString == null) {
      return [];
    }

    // Decode the JSON string to a list of maps.
    final List<dynamic> notesData = json.decode(notesJsonString);

    // Map each item in the list back to a Note object.
    return notesData.map((map) => Note.fromMap(map)).toList();
  }

  /// Saves a new note or updates an existing one in SharedPreferences.
  Future<void> saveNote(Note note) async {
    final prefs = await SharedPreferences.getInstance();
    final List<Note> allNotes = await getNotes();

    // Check if the note already exists (by ID) to decide whether to update or add.
    final int existingIndex = allNotes.indexWhere((n) => n.id == note.id);

    if (existingIndex != -1) {
      // Update existing note
      allNotes[existingIndex] = note;
    } else {
      // Add new note
      allNotes.add(note);
    }

    // Convert the list of Note objects back to a list of maps.
    final List<Map<String, dynamic>> notesToSave = allNotes.map((n) => n.toMap()).toList();

    // Encode the list of maps to a JSON string and save it.
    final String jsonString = json.encode(notesToSave);
    await prefs.setString(_notesKey, jsonString);

    print('Note "${note.title}" saved to storage.');
  }

  /// Deletes a note from SharedPreferences.
  Future<void> deleteNote(String noteId) async {
    final prefs = await SharedPreferences.getInstance();
    final List<Note> allNotes = await getNotes();

    // Remove the note with the matching ID.
    allNotes.removeWhere((note) => note.id == noteId);

    // Re-save the modified list of notes.
    final List<Map<String, dynamic>> notesToSave = allNotes.map((n) => n.toMap()).toList();
    await prefs.setString(_notesKey, json.encode(notesToSave));

    print('Note with ID "$noteId" deleted from storage.');
  }
}
