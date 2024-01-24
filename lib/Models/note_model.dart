class Note {
  int? id;
  String title;
  String content;
  DateTime time;

  Note({this.id, required this.title, required this.content, DateTime? time})
      : time = time ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'time': time.toIso8601String()
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      time: DateTime.parse(map['time']),
    );
  }
}
