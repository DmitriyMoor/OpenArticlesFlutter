import 'package:open_articles_flutter/common/network/load_exception.dart';
import 'package:open_articles_flutter/features/article/domain/article_model.dart';

sealed class ArticleListState {
  const ArticleListState({required this.query});

  final String query;
}

final class ArticleListLoading extends ArticleListState {
  const ArticleListLoading({required super.query});
}

final class ArticleListLoaded extends ArticleListState {
  const ArticleListLoaded({
    required super.query,
    required this.items,
    required this.page,
    required this.hasMore,
    this.isLoadingMore = false,
    this.loadMoreError,
  });

  final List<ArticleModel> items;
  final int page;
  final bool hasMore;
  final bool isLoadingMore;
  final LoadException? loadMoreError;

  ArticleListLoaded copyWith({
    List<ArticleModel>? items,
    int? page,
    bool? hasMore,
    bool? isLoadingMore,
    LoadException? loadMoreError,
  }) {
    return ArticleListLoaded(
      query: query,
      items: items ?? this.items,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      loadMoreError: loadMoreError,
    );
  }
}

final class ArticleListFailure extends ArticleListState {
  const ArticleListFailure({required super.query, required this.error});

  final LoadException error;
}
