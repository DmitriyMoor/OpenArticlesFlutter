import 'package:open_articles_flutter/features/article/data/dto/article_dto.dart';
import 'package:open_articles_flutter/features/article/data/dto/bibjson_dto.dart';
import 'package:open_articles_flutter/features/article/domain/article_model.dart';

extension ArticleDtoMapper on ArticleDto {
  ArticleModel toModel() {
    final bib = bibjson;
    return ArticleModel(
      id: id,
      title: bib.title.trim(),
      abstractText: bib.abstractText?.trim() ?? '',
      authors: [
        for (final author in bib.author)
          if (author.name != null && author.name!.trim().isNotEmpty)
            author.name!.trim(),
      ],
      journalTitle: bib.journal?.title ?? '',
      publisher: bib.journal?.publisher ?? '',
      keywords: bib.keywords,
      issn: bib.issn,
      year: int.tryParse(bib.year ?? ''),
      month: _month(bib.month),
      doi: bib.identifier.where((i) => i.type == 'doi').firstOrNull?.id,
      fullTextUrl: bib.link
          .where((link) => link.type == 'fulltext' && link.url != null)
          .firstOrNull
          ?.url,
    );
  }
}

extension on BibjsonDto {
  String? get issn {
    final fromJournal = journal?.issns.firstOrNull;
    if (fromJournal != null) return fromJournal;
    return identifier
        .where((i) => i.type == 'eissn' || i.type == 'pissn')
        .firstOrNull
        ?.id;
  }
}

int? _month(String? value) {
  final month = int.tryParse(value ?? '');
  if (month == null || month < 1 || month > 12) return null;
  return month;
}
