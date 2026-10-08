part of 'article_detail_cubit.dart';

enum ArticleDetailStatus { initial, loading, loaded, notFound, error }

class ArticleDetailState extends Equatable {
  final ArticleDetailStatus status;
  final ArticleModel? article;

  const ArticleDetailState({
    this.status = ArticleDetailStatus.initial,
    this.article,
  });

  ArticleDetailState copyWith({
    ArticleDetailStatus? status,
    ArticleModel? article,
  }) {
    return ArticleDetailState(
      status: status ?? this.status,
      article: article ?? this.article,
    );
  }

  @override
  List<Object?> get props => [status, article];
}