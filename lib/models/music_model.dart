class Music {
  String name;
  String author;
  String imagePath;
  String audioPath;

  Music(
      {required this.name,
      required this.author,
      required this.imagePath,
      required this.audioPath});

  factory Music.fromJson(Map<String, dynamic> json) {
    return Music(
        name: json['name'],
        author: json['author'],
        imagePath: json['imagePath'],
        audioPath: json['audioPath']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'author': author,
      'imagePath': imagePath,
      'audioPath': audioPath,
    };
  }
}
