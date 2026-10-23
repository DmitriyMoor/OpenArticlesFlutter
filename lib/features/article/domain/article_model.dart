class ArticleModel {
  const ArticleModel({
    required this.id,
    required this.title,
    required this.abstractText,
    required this.authors,
    required this.journalTitle,
    required this.publisher,
    required this.keywords,
    this.issn,
    this.year,
    this.month,
    this.doi,
    this.fullTextUrl,
  });

  final String id;
  final String title;
  final String abstractText;
  final List<String> authors;
  final String journalTitle;
  final String publisher;
  final List<String> keywords;
  final String? issn;
  final int? year;
  final int? month;
  final String? doi;
  final String? fullTextUrl;
}
