import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:open_articles_flutter/common/navigation/app_router.dart';
import 'package:open_articles_flutter/features/article/domain/article_model.dart';
import 'package:open_articles_flutter/features/article/presentation/utils/article_format.dart';
import 'package:open_articles_flutter/features/article/presentation/view/widgets/journal_avatar.dart';
import 'package:open_articles_flutter/l10n/app_localizations.dart';

class ArticleCard extends StatelessWidget {
  const ArticleCard({super.key, required this.article});

  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.push(AppRoutes.detail(article.id)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12,
            children: [
              JournalAvatar(article: article),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4,
                  children: [
                    Text(
                      article.title,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium,
                    ),
                    Text(
                      article.shortAuthors(l10n),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      article.journalWithYear,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
