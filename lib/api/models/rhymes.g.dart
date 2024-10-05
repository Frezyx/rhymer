// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rhymes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rhymes _$RhymesFromJson(Map<String, dynamic> json) => Rhymes(
      words: (json['words'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$RhymesToJson(Rhymes instance) => <String, dynamic>{
      'words': instance.words,
    };
