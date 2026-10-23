import 'package:json_annotation/json_annotation.dart';
import 'package:open_articles_flutter/features/article/data/dto/bibjson_dto.dart';

part 'article_dto.g.dart';

@JsonSerializable(checked: true, createToJson: false)
class ArticleDto {
  const ArticleDto({required this.id, required this.bibjson});

  factory ArticleDto.fromJson(Map<String, dynamic> json) =>
      _$ArticleDtoFromJson(json);

  final String id;
  final BibjsonDto bibjson;
}
