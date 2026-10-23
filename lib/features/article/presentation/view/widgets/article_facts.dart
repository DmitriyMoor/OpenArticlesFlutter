import 'package:flutter/material.dart';
import 'package:open_articles_flutter/features/article/domain/article_model.dart';
import 'package:open_articles_flutter/features/article/presentation/utils/article_format.dart';
import 'package:open_articles_flutter/l10n/app_localizations.dart';

class ArticleFacts extends StatelessWidget {
  const ArticleFacts({super.key, required this.article});

  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final date = article.publishedDate(locale);
    return Column(
      spacing: 6,
      children: [
        _FactRow(label: l10n.factJournal, value: article.journalTitle),
        if (article.publisher.isNotEmpty)
          _FactRow(label: l10n.factPublisher, value: article.publisher),
        if (date.isNotEmpty) _FactRow(label: l10n.factPublished, value: date),
        if (article.doi != null)
          _FactRow(label: l10n.factDoi, value: article.doi!),
        if (article.issn != null)
          _FactRow(label: l10n.factIssn, value: article.issn!),
      ],
    );
  }
}

class _FactRow extends StatelessWidget {
  const _FactRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 110,
          child: Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        Expanded(
          child: SelectableText(value, style: theme.textTheme.bodyMedium),
        ),
      ],
    );
  }
}
