import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
import 'package:rhymer/utils/database/drift.dart';

class FavoriteRhyme extends Equatable {
  const FavoriteRhyme({
    required this.id,
    required this.queryWord,
    required this.favoriteWord,
    required this.words,
    required this.createdAt,
  });

  final int id;
  final String queryWord;
  final String favoriteWord;
  final List<String> words;
  final DateTime createdAt;

  CreateFavoriteRhyme toCreate() => CreateFavoriteRhyme(
        queryWord: queryWord,
        favoriteWord: favoriteWord,
        words: words,
        createdAt: createdAt,
      );

  factory FavoriteRhyme.fromTable(FavoriteRhymeTableData data) {
    return FavoriteRhyme(
      id: data.id,
      queryWord: data.queryWord,
      favoriteWord: data.favoriteWord,
      words: jsonDecode(data.words) as List<String>,
      createdAt: data.createdAt,
    );
  }

  FavoriteRhyme copyWith({
    int? id,
    String? queryWord,
    String? favoriteWord,
    List<String>? words,
    DateTime? createdAt,
  }) {
    return FavoriteRhyme(
      id: id ?? this.id,
      queryWord: queryWord ?? this.queryWord,
      favoriteWord: favoriteWord ?? this.favoriteWord,
      words: words ?? this.words,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object> get props => [id, queryWord, favoriteWord, words, createdAt];
}

class CreateFavoriteRhyme extends Equatable {
  const CreateFavoriteRhyme({
    required this.queryWord,
    required this.favoriteWord,
    required this.words,
    required this.createdAt,
  });

  final String queryWord;
  final String favoriteWord;
  final List<String> words;
  final DateTime createdAt;

  factory CreateFavoriteRhyme.create({
    required String queryWord,
    required String favoriteWord,
    required List<String> words,
  }) =>
      CreateFavoriteRhyme(
        queryWord: queryWord,
        favoriteWord: favoriteWord,
        words: words,
        createdAt: DateTime.now(),
      );

  FavoriteRhymeTableCompanion toCompanion() {
    return FavoriteRhymeTableCompanion(
      queryWord: Value(queryWord),
      favoriteWord: Value(favoriteWord),
      words: Value(jsonEncode(words)),
      createdAt: Value(createdAt),
    );
  }

  @override
  List<Object> get props => [queryWord, favoriteWord, words, createdAt];
}
