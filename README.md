# Открытые статьи (Flutter)

Каталог научных статей открытого доступа. Источник данных — [DOAJ](https://doaj.org) (Directory of Open Access Journals).

Курс «Кроссплатформенная разработка», ПИН-252т.

## Запуск

```bash
flutter pub get
flutter run -d chrome
flutter run -d windows
```

Проверка, что ключи в ARB совпадают:

```bash
dart run tool/check_arb.dart
```

## Структура

```
lib/
  app.dart, main.dart
  common/        навигация, тема, настройки (тема и язык), общие виджеты
  features/
    article/
      data/          репозиторий
      domain/        модель статьи, интерфейс репозитория
      presentation/  bloc/, view/, view/widgets/, utils/
  l10n/          подписи на русском и английском
tool/check_arb.dart
```
