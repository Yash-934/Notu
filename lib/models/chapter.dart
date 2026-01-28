
enum ContentType { markdown, html }

class Chapter {
  int? id;
  int? bookId;
  String title;
  String content;
  ContentType contentType;

  Chapter({
    this.id,
    this.bookId,
    required this.title,
    required this.content,
    this.contentType = ContentType.markdown,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'book_id': bookId,
      'title': title,
      'content': content,
      'content_type': contentType.index,
    };
  }

  static Chapter fromMap(Map<String, dynamic> map) {
    return Chapter(
      id: map['id'],
      bookId: map['book_id'],
      title: map['title'],
      content: map['content'],
      contentType: ContentType.values[map['content_type'] ?? 0],
    );
  }
}
