import 'package:open_articles_flutter/features/article/data/mock_articles.dart';
import 'package:open_articles_flutter/features/article/domain/article_model.dart';
import 'package:open_articles_flutter/features/article/domain/i_article_repository.dart';

class ArticleRepository implements IArticleRepository {
  // задержка, чтобы было видно индикатор загрузки, как будто это сеть
  static const Duration _delay = Duration(milliseconds: 400);
  static const int _relatedLimit = 5;

  @override
  Future<List<ArticleModel>> getArticles({String query = ''}) async {
    await Future.delayed(_delay);
    final text = query.trim().toLowerCase();
    if (text.isEmpty) return mockArticles;
    return mockArticles.where((article) => _matches(article, text)).toList();
  }

  @override
  Future<ArticleModel?> getArticle(String id) async {
    await Future.delayed(_delay);
    return mockArticles.where((article) => article.id == id).firstOrNull;
  }

  @override
  Future<List<ArticleModel>> getRelated(ArticleModel article) async {
    await Future.delayed(_delay);
    return mockArticles
        .where((other) => other.issn == article.issn && other.id != article.id)
        .take(_relatedLimit)
        .toList();
  }

  bool _matches(ArticleModel article, String text) {
    return article.title.toLowerCase().contains(text) ||
        article.authors.any((name) => name.toLowerCase().contains(text)) ||
        article.keywords.any((word) => word.toLowerCase().contains(text));
  }
}
