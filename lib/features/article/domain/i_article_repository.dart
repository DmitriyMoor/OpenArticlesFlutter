import 'package:open_articles_flutter/features/article/domain/article_model.dart';
import 'package:open_articles_flutter/features/article/domain/article_page.dart';

abstract interface class IArticleRepository {
  Future<ArticlePage> getArticles({String query = '', int page = 1});

  Future<ArticleModel> getArticle(String id);

  Future<List<ArticleModel>> getRelated(ArticleModel article);
}
