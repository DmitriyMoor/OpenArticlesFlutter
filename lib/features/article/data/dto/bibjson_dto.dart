import 'package:json_annotation/json_annotation.dart';

part 'bibjson_dto.g.dart';

@JsonSerializable(checked: true, createToJson: false)
class BibjsonDto {
  const BibjsonDto({
    required this.title,
    this.abstractText,
    this.author = const [],
    this.journal,
    this.year,
    this.month,
    this.identifier = const [],
    this.keywords = const [],
    this.link = const [],
  });

  factory BibjsonDto.fromJson(Map<String, dynamic> json) =>
      _$BibjsonDtoFromJson(json);

  final String title;
  @JsonKey(name: 'abstract')
  final String? abstractText;
  final List<AuthorDto> author;
  final JournalDto? journal;
  final String? year;
  final String? month;
  final List<IdentifierDto> identifier;
  final List<String> keywords;
  final List<LinkDto> link;
}

@JsonSerializable(checked: true, createToJson: false)
class AuthorDto {
  const AuthorDto({this.name});

  factory AuthorDto.fromJson(Map<String, dynamic> json) =>
      _$AuthorDtoFromJson(json);

  final String? name;
}

@JsonSerializable(checked: true, createToJson: false)
class JournalDto {
  const JournalDto({this.title, this.publisher, this.issns = const []});

  factory JournalDto.fromJson(Map<String, dynamic> json) =>
      _$JournalDtoFromJson(json);

  final String? title;
  final String? publisher;
  final List<String> issns;
}

@JsonSerializable(checked: true, createToJson: false)
class IdentifierDto {
  const IdentifierDto({required this.type, required this.id});

  factory IdentifierDto.fromJson(Map<String, dynamic> json) =>
      _$IdentifierDtoFromJson(json);

  final String type;
  final String id;
}

@JsonSerializable(checked: true, createToJson: false)
class LinkDto {
  const LinkDto({this.type, this.url});

  factory LinkDto.fromJson(Map<String, dynamic> json) =>
      _$LinkDtoFromJson(json);

  final String? type;
  final String? url;
}
