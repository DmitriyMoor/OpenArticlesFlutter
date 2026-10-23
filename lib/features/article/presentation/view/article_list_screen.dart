import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_articles_flutter/common/widgets/app_scaffold.dart';
import 'package:open_articles_flutter/features/article/domain/article_model.dart';
import 'package:open_articles_flutter/features/article/presentation/bloc/list/article_list_cubit.dart';
import 'package:open_articles_flutter/features/article/presentation/bloc/list/article_list_state.dart';
import 'package:open_articles_flutter/features/article/presentation/view/widgets/article_card.dart';
import 'package:open_articles_flutter/features/article/presentation/view/widgets/search_field.dart';
import 'package:open_articles_flutter/l10n/app_localizations.dart';

class ArticleListScreen extends StatelessWidget {
  const ArticleListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ArticleListCubit>();
    return AppScaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: SearchField(
              initialText: cubit.state.query,
              onChanged: cubit.search,
            ),
          ),
          Expanded(
            child: BlocBuilder<ArticleListCubit, ArticleListState>(
              builder: (context, state) => switch (state) {
                ArticleListLoading() => const Center(
                  child: CircularProgressIndicator(),
                ),
                ArticleListLoaded(:final items) when items.isEmpty => Center(
                  child: Text(AppLocalizations.of(context).searchNothingFound),
                ),
                ArticleListLoaded(:final items) => _ArticleList(items: items),
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ArticleList extends StatelessWidget {
  const _ArticleList({required this.items});

  final List<ArticleModel> items;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      key: const PageStorageKey('article_list'),
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      itemCount: items.length,
      separatorBuilder: (_, _) => const SizedBox(height: 8),
      itemBuilder: (context, index) => ArticleCard(article: items[index]),
    );
  }
}
