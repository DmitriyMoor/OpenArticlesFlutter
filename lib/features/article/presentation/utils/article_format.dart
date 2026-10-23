import 'package:intl/intl.dart';
import 'package:open_articles_flutter/features/article/domain/article_model.dart';
import 'package:open_articles_flutter/l10n/app_localizations.dart';

extension ArticleFormat on ArticleModel {
  String get journalInitials {
    final words = journalTitle
        .split(RegExp(r'[\s\-]+'))
        .where((word) => word.isNotEmpty && word[0] != word[0].toLowerCase())
        .toList();
    if (words.isEmpty) return journalTitle.isEmpty ? '?' : journalTitle[0];
    return words.take(2).map((word) => word[0]).join();
  }

  String shortAuthors(AppLocalizations l10n) {
    if (authors.isEmpty) return l10n.noAuthors;
    if (authors.length <= 2) return authors.join(', ');
    return l10n.authorsAndMore(authors.take(2).join(', '), authors.length - 2);
  }

  String publishedDate(String locale) {
    if (year == null) return '';
    if (month == null) return '$year';
    return DateFormat.yMMMM(locale).format(DateTime(year!, month!));
  }

  String get journalWithYear {
    if (year == null) return journalTitle;
    return '$journalTitle · $year';
  }
}
