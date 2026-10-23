import 'package:open_articles_flutter/features/article/data/dto/article_dto.dart';
import 'package:open_articles_flutter/features/article/data/dto/search_page_dto.dart';

abstract interface class IArticleDataSource {
  Future<SearchPageDto> searchArticles({
    required String query,
    required int page,
    required int pageSize,
  });

  Future<ArticleDto> getArticle(String id);
}
