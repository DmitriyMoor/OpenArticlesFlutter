import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/article_model.dart';
import '../../../domain/i_article_repository.dart';

part 'article_list_state.dart';

class ArticleListCubit extends Cubit<ArticleListState> {
  final IArticleRepository _repository;

  ArticleListCubit(this._repository) : super(const ArticleListState());

  Future<void> search(String query) async {
    emit(state.copyWith(status: ArticleListStatus.loading, query: query));
    try {
      final items = await _repository.search(query);
      if (isClosed) return;
      if (items.isEmpty) {
        emit(state.copyWith(status: ArticleListStatus.notFound, items: []));
      } else {
        emit(state.copyWith(status: ArticleListStatus.loaded, items: items));
      }
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(status: ArticleListStatus.error, items: []));
    }
  }
}