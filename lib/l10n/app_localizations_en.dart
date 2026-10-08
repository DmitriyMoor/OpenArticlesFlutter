// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Open Articles';

  @override
  String get search => 'Search articles...';

  @override
  String get searchPrompt => 'Enter search query';

  @override
  String get nothingFound => 'Nothing found';

  @override
  String get articles => 'Articles';

  @override
  String get articleDetails => 'Article details';

  @override
  String get openJournal => 'Open journal';

  @override
  String get openRelatedArticle => 'Open related article';

  @override
  String get errorMessage => 'An error occurred';

  @override
  String authors(String authors) {
    return 'Authors: $authors';
  }

  @override
  String published(String date) {
    return 'Published: $date';
  }

  @override
  String journal(String name) {
    return 'Journal: $name';
  }
}
