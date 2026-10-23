import 'package:open_articles_flutter/features/article/domain/article_model.dart';

sealed class ArticleListState {
  const ArticleListState({required this.query});

  final String query;
}

final class ArticleListLoading extends ArticleListState {
  const ArticleListLoading({required super.query});
}

final class ArticleListLoaded extends ArticleListState {
  const ArticleListLoaded({required super.query, required this.items});

  final List<ArticleModel> items;
}
