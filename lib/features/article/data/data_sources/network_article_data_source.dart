import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:open_articles_flutter/common/network/load_exception.dart';
import 'package:open_articles_flutter/features/article/data/api/article_api.dart';
import 'package:open_articles_flutter/features/article/data/data_sources/i_article_data_source.dart';
import 'package:open_articles_flutter/features/article/data/dto/article_dto.dart';
import 'package:open_articles_flutter/features/article/data/dto/search_page_dto.dart';

class NetworkArticleDataSource implements IArticleDataSource {
  const NetworkArticleDataSource(this._api);

  final ArticleApi _api;

  @override
  Future<SearchPageDto> searchArticles({
    required String query,
    required int page,
    required int pageSize,
  }) => _guard(
    () => _api.searchArticles(query: query, page: page, pageSize: pageSize),
  );

  @override
  Future<ArticleDto> getArticle(String id) => _guard(() => _api.getArticle(id));

  Future<T> _guard<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on DioException catch (error) {
      throw _fromDio(error);
    } on CheckedFromJsonException {
      throw const BadResponseException();
    } on FormatException {
      throw const BadResponseException();
    }
  }

  LoadException _fromDio(DioException error) => switch (error.type) {
    DioExceptionType.connectionTimeout ||
    DioExceptionType.sendTimeout ||
    DioExceptionType.receiveTimeout => const TimeoutLoadException(),
    DioExceptionType.badResponse when error.response?.statusCode == 404 =>
      const NotFoundException(),
    DioExceptionType.badResponse => ServerException(error.response?.statusCode),
    DioExceptionType.unknown when error.error is FormatException =>
      const BadResponseException(),
    _ => const NoConnectionException(),
  };
}
