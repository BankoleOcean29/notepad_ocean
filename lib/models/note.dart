import 'package:uuid/uuid.dart';

final Uuid _uuid = const Uuid();

class Note {

  late final String id;

  late String title;

  late String content;

  late final DateTime createdAt;

  late final DateTime updatedAt;



  Note({
    String? id,
    required this.title,
    required this.content,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : id = id ?? _uuid.v4(), // Generate a new UUID if no ID is provided
        createdAt = createdAt ?? DateTime.now(), // Set creation time
        updatedAt = updatedAt ?? DateTime.now();


  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: DateTime.parse(map['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}