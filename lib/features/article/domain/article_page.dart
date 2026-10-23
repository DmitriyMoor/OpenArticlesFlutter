import 'package:open_articles_flutter/features/article/domain/article_model.dart';

class ArticlePage {
  const ArticlePage({required this.items, required this.hasMore});

  final List<ArticleModel> items;
  final bool hasMore;
}
