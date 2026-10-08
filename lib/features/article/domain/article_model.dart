import 'package:equatable/equatable.dart';

class ArticleModel extends Equatable {
  final String id;
  final String title;
  final String abstractText;
  final List<String> authors;
  final String publishedDate;
  final String journalTitle;
  final String? url;

  const ArticleModel({
    required this.id,
    required this.title,
    required this.abstractText,
    required this.authors,
    required this.publishedDate,
    required this.journalTitle,
    this.url,
  });

  @override
  List<Object?> get props => [id, title, abstractText, authors, publishedDate, journalTitle, url];
}