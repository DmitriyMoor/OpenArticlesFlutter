import 'package:dio/dio.dart';
import 'package:open_articles_flutter/features/article/data/dto/article_dto.dart';
import 'package:open_articles_flutter/features/article/data/dto/search_page_dto.dart';

class ArticleApi {
  const ArticleApi(this._dio);

  final Dio _dio;

  Future<SearchPageDto> searchArticles({
    required String query,
    required int page,
    required int pageSize,
  }) async {
    final json = await _getJson(
      '/search/articles/${Uri.encodeComponent(query)}',
      queryParameters: {'page': page, 'pageSize': pageSize},
    );
    return SearchPageDto.fromJson(json);
  }

  Future<ArticleDto> getArticle(String id) async {
    final json = await _getJson('/articles/${Uri.encodeComponent(id)}');
    return ArticleDto.fromJson(json);
  }

  Future<Map<String, dynamic>> _getJson(
    String path, {
    Map<String, Object>? queryParameters,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      path,
      queryParameters: queryParameters,
    );
    return response.data ?? (throw const FormatException('empty response'));
  }
}
