import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_articles_flutter/features/article/domain/i_article_repository.dart';
import 'package:open_articles_flutter/features/article/presentation/bloc/detail/article_detail_event.dart';
import 'package:open_articles_flutter/features/article/presentation/bloc/detail/article_detail_state.dart';

class ArticleDetailBloc extends Bloc<ArticleDetailEvent, ArticleDetailState> {
  ArticleDetailBloc(this._repository) : super(const ArticleDetailLoading()) {
    on<ArticleDetailOpened>(_onOpened);
  }

  final IArticleRepository _repository;

  Future<void> _onOpened(
    ArticleDetailOpened event,
    Emitter<ArticleDetailState> emit,
  ) async {
    emit(const ArticleDetailLoading());
    final article = await _repository.getArticle(event.id);
    if (article == null) {
      emit(ArticleDetailNotFound(event.id));
      return;
    }
    final related = await _repository.getRelated(article);
    emit(ArticleDetailLoaded(article: article, related: related));
  }
}
