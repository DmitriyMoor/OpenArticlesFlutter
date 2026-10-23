// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleDto _$ArticleDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ArticleDto', json, ($checkedConvert) {
      final val = ArticleDto(
        id: $checkedConvert('id', (v) => v as String),
        bibjson: $checkedConvert(
          'bibjson',
          (v) => BibjsonDto.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });
