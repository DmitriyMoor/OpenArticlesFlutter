import 'package:open_articles_flutter/features/article/data/data_sources/i_article_data_source.dart';
import 'package:open_articles_flutter/features/article/data/mappers/article_mapper.dart';
import 'package:open_articles_flutter/features/article/domain/article_model.dart';
import 'package:open_articles_flutter/features/article/domain/article_page.dart';
import 'package:open_articles_flutter/features/article/domain/i_article_repository.dart';

class ArticleRepository implements IArticleRepository {
  ArticleRepository(this._dataSource);

  final IArticleDataSource _dataSource;

  static const int _pageSize = 20;
  static const int _relatedLimit = 6;

  // DOAJ отдаёт не больше 1000 результатов на один запрос
  static const int _maxResults = 1000;

  // когда поиск пустой, показываем статьи по информатике
  static const String _defaultQuery =
      'bibjson.subject.term:"Electronic computers. Computer science"';

  @override
  Future<ArticlePage> getArticles({String query = '', int page = 1}) async {
    final text = _clean(query);
    final dto = await _dataSource.searchArticles(
      query: text.isEmpty ? _defaultQuery : text,
      page: page,
      pageSize: _pageSize,
    );
    final loaded = page * _pageSize;
    return ArticlePage(
      items: [for (final article in dto.results) article.toModel()],
      hasMore: loaded < dto.total && loaded < _maxResults,
    );
  }

  @override
  Future<ArticleModel> getArticle(String id) async {
    final dto = await _dataSource.getArticle(id);
    return dto.toModel();
  }

  @override
  Future<List<ArticleModel>> getRelated(ArticleModel article) async {
    final queries = [
      if (article.issn != null) 'issn:"${article.issn}"',
      if (article.keywords.isNotEmpty)
        'bibjson.keywords:"${_clean(article.keywords.first)}"',
    ];
    // оба запроса не зависят друг от друга, поэтому идут параллельно
    final pages = await Future.wait([
      for (final query in queries)
        _dataSource.searchArticles(
          query: query,
          page: 1,
          pageSize: _relatedLimit + 1,
        ),
    ]);

    final seen = {article.id};
    final related = <ArticleModel>[];
    for (final page in pages) {
      for (final dto in page.results) {
        if (seen.add(dto.id)) related.add(dto.toModel());
      }
    }
    return related.take(_relatedLimit).toList();
  }

  String _clean(String text) {
    return text
        .replaceAll(RegExp(r'[^\p{L}\p{N}\s]', unicode: true), ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }
}
