import 'package:intl/intl.dart';
import '../../domain/article_model.dart';

extension ArticleFormatExt on ArticleModel {
  String get formattedPublishedDate {
    try {
      final date = DateTime.parse(publishedDate);
      return DateFormat.yMMMMd().format(date);
    } catch (_) {
      return publishedDate;
    }
  }
}