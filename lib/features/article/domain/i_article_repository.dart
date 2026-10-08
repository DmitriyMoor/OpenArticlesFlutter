import 'article_model.dart';

abstract interface class IArticleRepository {
  Future<List<ArticleModel>> search(String query);
  Future<ArticleModel?> getById(String id);
}