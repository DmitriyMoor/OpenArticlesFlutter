import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_articles_flutter/common/network/load_exception.dart';
import 'package:open_articles_flutter/features/article/domain/i_article_repository.dart';
import 'package:open_articles_flutter/features/article/presentation/bloc/list/article_list_state.dart';

class ArticleListCubit extends Cubit<ArticleListState> {
  ArticleListCubit(this._repository)
    : super(const ArticleListLoading(query: ''));

  final IArticleRepository _repository;

  static const Duration _searchDelay = Duration(milliseconds: 400);

  Timer? _searchTimer;

  Future<void> load() => _load('');

  Future<void> retry() => _load(state.query);

  void search(String query) {
    _searchTimer?.cancel();
    _searchTimer = Timer(_searchDelay, () => _load(query.trim()));
  }

  Future<void> loadMore() async {
    final current = state;
    if (current is! ArticleListLoaded ||
        !current.hasMore ||
        current.isLoadingMore) {
      return;
    }
    emit(current.copyWith(isLoadingMore: true));
    try {
      final next = await _repository.getArticles(
        query: current.query,
        page: current.page + 1,
      );
      if (isClosed || state.query != current.query) return;
      final ids = {for (final article in current.items) article.id};
      emit(
        current.copyWith(
          items: [
            ...current.items,
            ...next.items.where((article) => !ids.contains(article.id)),
          ],
          page: current.page + 1,
          hasMore: next.hasMore,
          isLoadingMore: false,
        ),
      );
    } on LoadException catch (error) {
      if (isClosed || state.query != current.query) return;
      emit(current.copyWith(isLoadingMore: false, loadMoreError: error));
    }
  }

  Future<void> _load(String query) async {
    emit(ArticleListLoading(query: query));
    try {
      final page = await _repository.getArticles(query: query);
      // пока ждали ответ, могли ввести другой запрос
      if (isClosed || state.query != query) return;
      emit(
        ArticleListLoaded(
          query: query,
          items: page.items,
          page: 1,
          hasMore: page.hasMore,
        ),
      );
    } on LoadException catch (error) {
      if (isClosed || state.query != query) return;
      emit(ArticleListFailure(query: query, error: error));
    }
  }

  @override
  Future<void> close() {
    _searchTimer?.cancel();
    return super.close();
  }
}
