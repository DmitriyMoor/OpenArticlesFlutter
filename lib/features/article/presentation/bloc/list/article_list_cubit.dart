import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_articles_flutter/features/article/domain/i_article_repository.dart';
import 'package:open_articles_flutter/features/article/presentation/bloc/list/article_list_state.dart';

class ArticleListCubit extends Cubit<ArticleListState> {
  ArticleListCubit(this._repository)
    : super(const ArticleListLoading(query: ''));

  final IArticleRepository _repository;

  static const Duration _searchDelay = Duration(milliseconds: 400);

  Timer? _searchTimer;

  Future<void> load() => _load('');

  void search(String query) {
    _searchTimer?.cancel();
    _searchTimer = Timer(_searchDelay, () => _load(query.trim()));
  }

  Future<void> _load(String query) async {
    emit(ArticleListLoading(query: query));
    final items = await _repository.getArticles(query: query);
    // пока ждали ответ, могли ввести другой запрос
    if (isClosed || state.query != query) return;
    emit(ArticleListLoaded(query: query, items: items));
  }

  @override
  Future<void> close() {
    _searchTimer?.cancel();
    return super.close();
  }
}
