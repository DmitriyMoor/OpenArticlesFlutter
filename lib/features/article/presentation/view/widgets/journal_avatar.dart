import 'package:flutter/material.dart';
import 'package:open_articles_flutter/features/article/domain/article_model.dart';
import 'package:open_articles_flutter/features/article/presentation/utils/article_format.dart';

// у DOAJ нет картинок, поэтому вместо обложки буквы журнала
class JournalAvatar extends StatelessWidget {
  const JournalAvatar({super.key, required this.article, this.size = 48});

  final ArticleModel article;
  final double size;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: colors.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        article.journalInitials,
        style: TextStyle(
          color: colors.onPrimaryContainer,
          fontWeight: FontWeight.bold,
          fontSize: size * 0.35,
        ),
      ),
    );
  }
}
