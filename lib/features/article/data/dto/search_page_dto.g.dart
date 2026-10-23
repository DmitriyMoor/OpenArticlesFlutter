// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_page_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchPageDto _$SearchPageDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SearchPageDto', json, ($checkedConvert) {
      final val = SearchPageDto(
        total: $checkedConvert('total', (v) => (v as num).toInt()),
        page: $checkedConvert('page', (v) => (v as num).toInt()),
        pageSize: $checkedConvert('pageSize', (v) => (v as num).toInt()),
        results: $checkedConvert(
          'results',
          (v) => (v as List<dynamic>)
              .map((e) => ArticleDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });
