import 'package:json_annotation/json_annotation.dart';

part 'rhymes.g.dart';

@JsonSerializable()
class RhymesDto {
  const RhymesDto({
    this.rhymes,
    this.stressedChars,
  });

  final List<String>? rhymes;
  final List<String>? stressedChars;

  factory RhymesDto.fromJson(Map<String, dynamic> json) =>
      _$RhymesDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RhymesDtoToJson(this);
}
