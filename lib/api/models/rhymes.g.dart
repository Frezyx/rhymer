// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rhymes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RhymesDto _$RhymesDtoFromJson(Map<String, dynamic> json) => RhymesDto(
      rhymes:
          (json['rhymes'] as List<dynamic>?)?.map((e) => e as String).toList(),
      stressedChars: (json['stressedChars'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$RhymesDtoToJson(RhymesDto instance) => <String, dynamic>{
      'rhymes': instance.rhymes,
      'stressedChars': instance.stressedChars,
    };
