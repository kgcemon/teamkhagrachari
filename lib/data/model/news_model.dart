class NewsModel {
  final String title;
  final String content;
  final String date;
  final String thumbnail;

  NewsModel({
    required this.title,
    required this.content,
    required this.date,
    required this.thumbnail,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      title: json['title'],
      content: json['content'],
      date: json['date'],
      thumbnail: json['thumbnail'],
    );
  }
}
