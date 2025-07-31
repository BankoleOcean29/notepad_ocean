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



}