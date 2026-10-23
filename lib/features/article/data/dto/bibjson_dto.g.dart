// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bibjson_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BibjsonDto _$BibjsonDtoFromJson(Map<String, dynamic> json) => $checkedCreate(
  'BibjsonDto',
  json,
  ($checkedConvert) {
    final val = BibjsonDto(
      title: $checkedConvert('title', (v) => v as String),
      abstractText: $checkedConvert('abstract', (v) => v as String?),
      author: $checkedConvert(
        'author',
        (v) =>
            (v as List<dynamic>?)
                ?.map((e) => AuthorDto.fromJson(e as Map<String, dynamic>))
                .toList() ??
            const [],
      ),
      journal: $checkedConvert(
        'journal',
        (v) =>
            v == null ? null : JournalDto.fromJson(v as Map<String, dynamic>),
      ),
      year: $checkedConvert('year', (v) => v as String?),
      month: $checkedConvert('month', (v) => v as String?),
      identifier: $checkedConvert(
        'identifier',
        (v) =>
            (v as List<dynamic>?)
                ?.map((e) => IdentifierDto.fromJson(e as Map<String, dynamic>))
                .toList() ??
            const [],
      ),
      keywords: $checkedConvert(
        'keywords',
        (v) =>
            (v as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
      ),
      link: $checkedConvert(
        'link',
        (v) =>
            (v as List<dynamic>?)
                ?.map((e) => LinkDto.fromJson(e as Map<String, dynamic>))
                .toList() ??
            const [],
      ),
    );
    return val;
  },
  fieldKeyMap: const {'abstractText': 'abstract'},
);

AuthorDto _$AuthorDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AuthorDto', json, ($checkedConvert) {
      final val = AuthorDto(name: $checkedConvert('name', (v) => v as String?));
      return val;
    });

JournalDto _$JournalDtoFromJson(Map<String, dynamic> json) => $checkedCreate(
  'JournalDto',
  json,
  ($checkedConvert) {
    final val = JournalDto(
      title: $checkedConvert('title', (v) => v as String?),
      publisher: $checkedConvert('publisher', (v) => v as String?),
      issns: $checkedConvert(
        'issns',
        (v) =>
            (v as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
      ),
    );
    return val;
  },
);

IdentifierDto _$IdentifierDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('IdentifierDto', json, ($checkedConvert) {
      final val = IdentifierDto(
        type: $checkedConvert('type', (v) => v as String),
        id: $checkedConvert('id', (v) => v as String),
      );
      return val;
    });

LinkDto _$LinkDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('LinkDto', json, ($checkedConvert) {
      final val = LinkDto(
        type: $checkedConvert('type', (v) => v as String?),
        url: $checkedConvert('url', (v) => v as String?),
      );
      return val;
    });
