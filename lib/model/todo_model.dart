import 'dart:convert';

class ToDo {
  final String docid;
  final String title;
  final String description;
  final String userId;

  ToDo({
    required this.docid,
    required this.title,
    required this.description,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'docid': docid,
      'title': title,
      'description': description,
      'userId': userId,
    };
  }

  factory ToDo.fromMap(Map<String, dynamic> map) {
    return ToDo(
      docid: map['docid'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      userId: map['userId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ToDo.fromJson(String source) => ToDo.fromMap(json.decode(source));
}
