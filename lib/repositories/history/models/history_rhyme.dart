import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
import 'package:rhymer/utils/database/drift.dart';

class HistoryRhyme extends Equatable {
  const HistoryRhyme({
    required this.id,
    required this.queryWord,
    required this.words,
    required this.createdAt,
  });

  final int id;
  final String queryWord;
  final List<String> words;
  final DateTime createdAt;

  CreateHistoryRhyme toCreate() => CreateHistoryRhyme(
        queryWord: queryWord,
        words: words,
        createdAt: createdAt,
      );

  factory HistoryRhyme.fromTable(HistoryRhymeModelData data) {
    final decoded = List<String>.from(jsonDecode(data.words));
    final words = data.words.isEmpty ? <String>[] : decoded;
    return HistoryRhyme(
      id: data.id,
      queryWord: data.queryWord,
      words: words,
      createdAt: data.createdAt,
    );
  }

  HistoryRhyme copyWith({
    int? id,
    String? queryWord,
    String? favoriteWord,
    List<String>? words,
    DateTime? createdAt,
  }) {
    return HistoryRhyme(
      id: id ?? this.id,
      queryWord: queryWord ?? this.queryWord,
      words: words ?? this.words,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object> get props => [id, queryWord, words, createdAt];
}

class CreateHistoryRhyme extends Equatable {
  const CreateHistoryRhyme({
    required this.queryWord,
    required this.words,
    required this.createdAt,
  });

  final String queryWord;
  final List<String> words;
  final DateTime createdAt;

  factory CreateHistoryRhyme.create({
    required String queryWord,
    required List<String> words,
  }) =>
      CreateHistoryRhyme(
        queryWord: queryWord,
        words: words,
        createdAt: DateTime.now(),
      );

  HistoryRhymeModelCompanion toCompanion() {
    return HistoryRhymeModelCompanion(
      queryWord: Value(queryWord),
      words: Value(jsonEncode(words)),
      createdAt: Value(createdAt),
    );
  }

  @override
  List<Object> get props => [queryWord, words, createdAt];
}
