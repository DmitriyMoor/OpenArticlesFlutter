# Открытые статьи (Flutter)

Каталог научных статей открытого доступа. Источник данных — [DOAJ](https://doaj.org) (Directory of Open Access Journals).

Курс «Кроссплатформенная разработка», ПИН-252т.

## Запуск

```bash
flutter pub get
flutter run -d chrome
flutter run -d windows
```

После правки DTO нужно перегенерировать `*.g.dart`:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Проверка, что ключи в ARB совпадают:

```bash
dart run tool/check_arb.dart
```

## Сеть

Данные берутся из API DOAJ (`https://doaj.org/api`), у него есть CORS, поэтому всё работает и в браузере.

Цепочка: `Dio` → `ArticleApi` → `NetworkArticleDataSource` → `ArticleRepository` → Cubit/Bloc → экран.

## Структура

```
lib/
  app.dart, main.dart
  common/        навигация, тема, настройки (тема и язык), сеть (Dio, LoadException), общие виджеты
  features/
    article/
      data/          api/, dto/, data_sources/, mappers/, репозиторий
      domain/        модель статьи, страница списка, интерфейс репозитория
      presentation/  bloc/, view/, view/widgets/, utils/
  l10n/          подписи на русском и английском
tool/check_arb.dart
```
