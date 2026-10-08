part of 'article_list_cubit.dart';

enum ArticleListStatus { initial, loading, loaded, notFound, error }

class ArticleListState extends Equatable {
  final ArticleListStatus status;
  final List<ArticleModel> items;
  final String query;

  const ArticleListState({
    this.status = ArticleListStatus.initial,
    this.items = const [],
    this.query = '',
  });

  ArticleListState copyWith({
    ArticleListStatus? status,
    List<ArticleModel>? items,
    String? query,
  }) {
    return ArticleListState(
      status: status ?? this.status,
      items: items ?? this.items,
      query: query ?? this.query,
    );
  }

  @override
  List<Object> get props => [status, items, query];
}