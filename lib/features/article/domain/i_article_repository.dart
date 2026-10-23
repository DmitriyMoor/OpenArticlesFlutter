import 'package:open_articles_flutter/features/article/domain/article_model.dart';

abstract interface class IArticleRepository {
  Future<List<ArticleModel>> getArticles({String query = ''});

  Future<ArticleModel?> getArticle(String id);

  Future<List<ArticleModel>> getRelated(ArticleModel article);
}
