import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/article_model.dart';
import '../../../domain/i_article_repository.dart';

part 'article_detail_state.dart';

class ArticleDetailCubit extends Cubit<ArticleDetailState> {
  final IArticleRepository _repository;
  final String id;

  ArticleDetailCubit(this._repository, {required this.id})
      : super(const ArticleDetailState()) {
    _load();
  }

  Future<void> _load() async {
    emit(state.copyWith(status: ArticleDetailStatus.loading));
    try {
      final article = await _repository.getById(id);
      if (isClosed) return;
      if (article == null) {
        emit(state.copyWith(status: ArticleDetailStatus.notFound));
      } else {
        emit(state.copyWith(status: ArticleDetailStatus.loaded, article: article));
      }
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(status: ArticleDetailStatus.error));
    }
  }
}