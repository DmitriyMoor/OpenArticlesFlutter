// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Открытые статьи';

  @override
  String get search => 'Поиск статей...';

  @override
  String get searchPrompt => 'Введите поисковый запрос';

  @override
  String get nothingFound => 'Ничего не найдено';

  @override
  String get articles => 'Статьи';

  @override
  String get articleDetails => 'Детали статьи';

  @override
  String get openJournal => 'Открыть журнал';

  @override
  String get openRelatedArticle => 'Открыть связанную статью';

  @override
  String get errorMessage => 'Произошла ошибка';

  @override
  String authors(String authors) {
    return 'Авторы: $authors';
  }

  @override
  String published(String date) {
    return 'Опубликовано: $date';
  }

  @override
  String journal(String name) {
    return 'Журнал: $name';
  }
}
