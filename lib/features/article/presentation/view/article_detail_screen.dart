import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../domain/i_article_repository.dart';
import '../bloc/detail/article_detail_cubit.dart';
import '../utils/article_format_ext.dart';

class ArticleDetailScreen extends StatelessWidget {
  final String id;

  const ArticleDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ArticleDetailCubit(
        context.read<IArticleRepository>(),
        id: id,
      ),
      child: const _ArticleDetailView(),
    );
  }
}

class _ArticleDetailView extends StatelessWidget {
  const _ArticleDetailView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.articleDetails),
      ),
      body: BlocBuilder<ArticleDetailCubit, ArticleDetailState>(
        builder: (context, state) {
          if (state.status == ArticleDetailStatus.loading || state.status == ArticleDetailStatus.initial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == ArticleDetailStatus.notFound) {
            return Center(child: Text(l10n.nothingFound));
          } else if (state.status == ArticleDetailStatus.error) {
            return Center(child: Text(l10n.errorMessage));
          }

          final article = state.article!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.title,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.authors(article.authors.join(', ')),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.published(article.formattedPublishedDate),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 16),
                Text(
                  article.abstractText,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () {
                    if (article.url != null) {
                      launchUrl(Uri.parse(article.url!));
                    }
                  },
                  icon: const Icon(Icons.open_in_browser),
                  label: Text(l10n.openJournal),
                ),
                const SizedBox(height: 16),
                // Feature: Open related record from details
                ElevatedButton(
                  onPressed: () {
                    // Just open another random article to demonstrate the related record feature
                    context.push('/article/id_1');
                  },
                  child: Text(l10n.openRelatedArticle),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}