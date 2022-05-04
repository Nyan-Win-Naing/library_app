class DummyBookVO {
  String bookName;
  String author;
  String description;

  DummyBookVO({required this.bookName, required this.author, required this.description});

  @override
  String toString() {
    return 'DummyBookVO{bookName: $bookName}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DummyBookVO &&
          runtimeType == other.runtimeType &&
          bookName == other.bookName &&
          author == other.author &&
          description == other.description;

  @override
  int get hashCode =>
      bookName.hashCode ^ author.hashCode ^ description.hashCode;
}