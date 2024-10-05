import 'package:json_annotation/json_annotation.dart';
import 'package:realm/realm.dart';
import 'package:rhymer/repositories/history/models/history_rhymes.dart';

part 'rhymes.g.dart';

@JsonSerializable()
class Rhymes {
  const Rhymes({required this.words});

  factory Rhymes.fromJson(Map<String, dynamic> json) => _$RhymesFromJson(json);

  final List<String> words;

  Map<String, dynamic> toJson() => _$RhymesToJson(this);

  HistoryRhymes toHistory(String queryWord) => HistoryRhymes(
        Uuid.v4().toString(),
        queryWord,
        words: words,
      );
}
