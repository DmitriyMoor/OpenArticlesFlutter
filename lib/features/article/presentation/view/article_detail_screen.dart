import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_articles_flutter/common/widgets/app_scaffold.dart';
import 'package:open_articles_flutter/features/article/domain/article_model.dart';
import 'package:open_articles_flutter/features/article/domain/i_article_repository.dart';
import 'package:open_articles_flutter/features/article/presentation/bloc/detail/article_detail_bloc.dart';
import 'package:open_articles_flutter/features/article/presentation/bloc/detail/article_detail_event.dart';
import 'package:open_articles_flutter/features/article/presentation/bloc/detail/article_detail_state.dart';
import 'package:open_articles_flutter/features/article/presentation/view/widgets/article_card.dart';
import 'package:open_articles_flutter/features/article/presentation/view/widgets/article_facts.dart';
import 'package:open_articles_flutter/features/article/presentation/view/widgets/section_title.dart';
import 'package:open_articles_flutter/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleDetailScreen extends StatelessWidget {
  const ArticleDetailScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ArticleDetailBloc(context.read<IArticleRepository>())
            ..add(ArticleDetailOpened(id)),
      child: AppScaffold(
        body: BlocBuilder<ArticleDetailBloc, ArticleDetailState>(
          builder: (context, state) => switch (state) {
            ArticleDetailLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
            ArticleDetailNotFound() => Center(
              child: Text(AppLocalizations.of(context).articleNotFound),
            ),
            ArticleDetailLoaded(:final article, :final related) =>
              _ArticleContent(article: article, related: related),
          },
        ),
      ),
    );
  }
}

class _ArticleContent extends StatelessWidget {
  const _ArticleContent({required this.article, required this.related});

  final ArticleModel article;
  final List<ArticleModel> related;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final url = article.fullTextUrl;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Text(article.title, style: theme.textTheme.headlineSmall),
          Text(
            article.authors.isEmpty
                ? l10n.noAuthors
                : article.authors.join(', '),
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 4),
          ArticleFacts(article: article),
          if (url != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: FilledButton.icon(
                onPressed: () => launchUrl(Uri.parse(url)),
                icon: const Icon(Icons.open_in_new),
                label: Text(l10n.actionOpenFullText),
              ),
            ),
          SectionTitle(l10n.sectionAbstract),
          Text(
            article.abstractText.isEmpty
                ? l10n.noAbstract
                : article.abstractText,
            style: theme.textTheme.bodyMedium,
          ),
          if (article.keywords.isNotEmpty) ...[
            SectionTitle(l10n.sectionKeywords),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final keyword in article.keywords)
                  Chip(label: Text(keyword)),
              ],
            ),
          ],
          if (related.isNotEmpty) ...[
            SectionTitle(l10n.sectionMoreFromJournal),
            for (final other in related) ArticleCard(article: other),
          ],
        ],
      ),
    );
  }
}
