
class Book {
  final int? id;
  final String title;
  final String? thumbnail;

  Book({this.id, required this.title, this.thumbnail});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'thumbnail': thumbnail,
    };
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'],
      title: map['title'],
      thumbnail: map['thumbnail'],
    );
  }
}
