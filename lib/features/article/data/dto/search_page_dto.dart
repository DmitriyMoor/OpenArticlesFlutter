import 'package:json_annotation/json_annotation.dart';
import 'package:open_articles_flutter/features/article/data/dto/article_dto.dart';

part 'search_page_dto.g.dart';

@JsonSerializable(checked: true, createToJson: false)
class SearchPageDto {
  const SearchPageDto({
    required this.total,
    required this.page,
    required this.pageSize,
    required this.results,
  });

  factory SearchPageDto.fromJson(Map<String, dynamic> json) =>
      _$SearchPageDtoFromJson(json);

  final int total;
  final int page;
  final int pageSize;
  final List<ArticleDto> results;
}
