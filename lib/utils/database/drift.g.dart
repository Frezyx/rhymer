// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift.dart';

// ignore_for_file: type=lint
class $FavoriteRhymeModelTable extends FavoriteRhymeModel
    with TableInfo<$FavoriteRhymeModelTable, FavoriteRhymeModelData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoriteRhymeModelTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _queryWordMeta =
      const VerificationMeta('queryWord');
  @override
  late final GeneratedColumn<String> queryWord = GeneratedColumn<String>(
      'query_word', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _favoriteWordMeta =
      const VerificationMeta('favoriteWord');
  @override
  late final GeneratedColumn<String> favoriteWord = GeneratedColumn<String>(
      'favorite_word', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _wordsMeta = const VerificationMeta('words');
  @override
  late final GeneratedColumn<String> words = GeneratedColumn<String>(
      'words', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, queryWord, favoriteWord, words, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorite_rhyme_model';
  @override
  VerificationContext validateIntegrity(
      Insertable<FavoriteRhymeModelData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('query_word')) {
      context.handle(_queryWordMeta,
          queryWord.isAcceptableOrUnknown(data['query_word']!, _queryWordMeta));
    } else if (isInserting) {
      context.missing(_queryWordMeta);
    }
    if (data.containsKey('favorite_word')) {
      context.handle(
          _favoriteWordMeta,
          favoriteWord.isAcceptableOrUnknown(
              data['favorite_word']!, _favoriteWordMeta));
    } else if (isInserting) {
      context.missing(_favoriteWordMeta);
    }
    if (data.containsKey('words')) {
      context.handle(
          _wordsMeta, words.isAcceptableOrUnknown(data['words']!, _wordsMeta));
    } else if (isInserting) {
      context.missing(_wordsMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FavoriteRhymeModelData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FavoriteRhymeModelData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      queryWord: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}query_word'])!,
      favoriteWord: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}favorite_word'])!,
      words: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}words'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $FavoriteRhymeModelTable createAlias(String alias) {
    return $FavoriteRhymeModelTable(attachedDatabase, alias);
  }
}

class FavoriteRhymeModelData extends DataClass
    implements Insertable<FavoriteRhymeModelData> {
  final int id;
  final String queryWord;
  final String favoriteWord;
  final String words;
  final DateTime createdAt;
  const FavoriteRhymeModelData(
      {required this.id,
      required this.queryWord,
      required this.favoriteWord,
      required this.words,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['query_word'] = Variable<String>(queryWord);
    map['favorite_word'] = Variable<String>(favoriteWord);
    map['words'] = Variable<String>(words);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  FavoriteRhymeModelCompanion toCompanion(bool nullToAbsent) {
    return FavoriteRhymeModelCompanion(
      id: Value(id),
      queryWord: Value(queryWord),
      favoriteWord: Value(favoriteWord),
      words: Value(words),
      createdAt: Value(createdAt),
    );
  }

  factory FavoriteRhymeModelData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavoriteRhymeModelData(
      id: serializer.fromJson<int>(json['id']),
      queryWord: serializer.fromJson<String>(json['queryWord']),
      favoriteWord: serializer.fromJson<String>(json['favoriteWord']),
      words: serializer.fromJson<String>(json['words']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'queryWord': serializer.toJson<String>(queryWord),
      'favoriteWord': serializer.toJson<String>(favoriteWord),
      'words': serializer.toJson<String>(words),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  FavoriteRhymeModelData copyWith(
          {int? id,
          String? queryWord,
          String? favoriteWord,
          String? words,
          DateTime? createdAt}) =>
      FavoriteRhymeModelData(
        id: id ?? this.id,
        queryWord: queryWord ?? this.queryWord,
        favoriteWord: favoriteWord ?? this.favoriteWord,
        words: words ?? this.words,
        createdAt: createdAt ?? this.createdAt,
      );
  FavoriteRhymeModelData copyWithCompanion(FavoriteRhymeModelCompanion data) {
    return FavoriteRhymeModelData(
      id: data.id.present ? data.id.value : this.id,
      queryWord: data.queryWord.present ? data.queryWord.value : this.queryWord,
      favoriteWord: data.favoriteWord.present
          ? data.favoriteWord.value
          : this.favoriteWord,
      words: data.words.present ? data.words.value : this.words,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteRhymeModelData(')
          ..write('id: $id, ')
          ..write('queryWord: $queryWord, ')
          ..write('favoriteWord: $favoriteWord, ')
          ..write('words: $words, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, queryWord, favoriteWord, words, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoriteRhymeModelData &&
          other.id == this.id &&
          other.queryWord == this.queryWord &&
          other.favoriteWord == this.favoriteWord &&
          other.words == this.words &&
          other.createdAt == this.createdAt);
}

class FavoriteRhymeModelCompanion
    extends UpdateCompanion<FavoriteRhymeModelData> {
  final Value<int> id;
  final Value<String> queryWord;
  final Value<String> favoriteWord;
  final Value<String> words;
  final Value<DateTime> createdAt;
  const FavoriteRhymeModelCompanion({
    this.id = const Value.absent(),
    this.queryWord = const Value.absent(),
    this.favoriteWord = const Value.absent(),
    this.words = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  FavoriteRhymeModelCompanion.insert({
    this.id = const Value.absent(),
    required String queryWord,
    required String favoriteWord,
    required String words,
    required DateTime createdAt,
  })  : queryWord = Value(queryWord),
        favoriteWord = Value(favoriteWord),
        words = Value(words),
        createdAt = Value(createdAt);
  static Insertable<FavoriteRhymeModelData> custom({
    Expression<int>? id,
    Expression<String>? queryWord,
    Expression<String>? favoriteWord,
    Expression<String>? words,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (queryWord != null) 'query_word': queryWord,
      if (favoriteWord != null) 'favorite_word': favoriteWord,
      if (words != null) 'words': words,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  FavoriteRhymeModelCompanion copyWith(
      {Value<int>? id,
      Value<String>? queryWord,
      Value<String>? favoriteWord,
      Value<String>? words,
      Value<DateTime>? createdAt}) {
    return FavoriteRhymeModelCompanion(
      id: id ?? this.id,
      queryWord: queryWord ?? this.queryWord,
      favoriteWord: favoriteWord ?? this.favoriteWord,
      words: words ?? this.words,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (queryWord.present) {
      map['query_word'] = Variable<String>(queryWord.value);
    }
    if (favoriteWord.present) {
      map['favorite_word'] = Variable<String>(favoriteWord.value);
    }
    if (words.present) {
      map['words'] = Variable<String>(words.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteRhymeModelCompanion(')
          ..write('id: $id, ')
          ..write('queryWord: $queryWord, ')
          ..write('favoriteWord: $favoriteWord, ')
          ..write('words: $words, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $HistoryRhymeModelTable extends HistoryRhymeModel
    with TableInfo<$HistoryRhymeModelTable, HistoryRhymeModelData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HistoryRhymeModelTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _queryWordMeta =
      const VerificationMeta('queryWord');
  @override
  late final GeneratedColumn<String> queryWord = GeneratedColumn<String>(
      'query_word', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _wordsMeta = const VerificationMeta('words');
  @override
  late final GeneratedColumn<String> words = GeneratedColumn<String>(
      'words', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, queryWord, words, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'history_rhyme_model';
  @override
  VerificationContext validateIntegrity(
      Insertable<HistoryRhymeModelData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('query_word')) {
      context.handle(_queryWordMeta,
          queryWord.isAcceptableOrUnknown(data['query_word']!, _queryWordMeta));
    } else if (isInserting) {
      context.missing(_queryWordMeta);
    }
    if (data.containsKey('words')) {
      context.handle(
          _wordsMeta, words.isAcceptableOrUnknown(data['words']!, _wordsMeta));
    } else if (isInserting) {
      context.missing(_wordsMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HistoryRhymeModelData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HistoryRhymeModelData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      queryWord: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}query_word'])!,
      words: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}words'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $HistoryRhymeModelTable createAlias(String alias) {
    return $HistoryRhymeModelTable(attachedDatabase, alias);
  }
}

class HistoryRhymeModelData extends DataClass
    implements Insertable<HistoryRhymeModelData> {
  final int id;
  final String queryWord;
  final String words;
  final DateTime createdAt;
  const HistoryRhymeModelData(
      {required this.id,
      required this.queryWord,
      required this.words,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['query_word'] = Variable<String>(queryWord);
    map['words'] = Variable<String>(words);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  HistoryRhymeModelCompanion toCompanion(bool nullToAbsent) {
    return HistoryRhymeModelCompanion(
      id: Value(id),
      queryWord: Value(queryWord),
      words: Value(words),
      createdAt: Value(createdAt),
    );
  }

  factory HistoryRhymeModelData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HistoryRhymeModelData(
      id: serializer.fromJson<int>(json['id']),
      queryWord: serializer.fromJson<String>(json['queryWord']),
      words: serializer.fromJson<String>(json['words']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'queryWord': serializer.toJson<String>(queryWord),
      'words': serializer.toJson<String>(words),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  HistoryRhymeModelData copyWith(
          {int? id, String? queryWord, String? words, DateTime? createdAt}) =>
      HistoryRhymeModelData(
        id: id ?? this.id,
        queryWord: queryWord ?? this.queryWord,
        words: words ?? this.words,
        createdAt: createdAt ?? this.createdAt,
      );
  HistoryRhymeModelData copyWithCompanion(HistoryRhymeModelCompanion data) {
    return HistoryRhymeModelData(
      id: data.id.present ? data.id.value : this.id,
      queryWord: data.queryWord.present ? data.queryWord.value : this.queryWord,
      words: data.words.present ? data.words.value : this.words,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HistoryRhymeModelData(')
          ..write('id: $id, ')
          ..write('queryWord: $queryWord, ')
          ..write('words: $words, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, queryWord, words, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HistoryRhymeModelData &&
          other.id == this.id &&
          other.queryWord == this.queryWord &&
          other.words == this.words &&
          other.createdAt == this.createdAt);
}

class HistoryRhymeModelCompanion
    extends UpdateCompanion<HistoryRhymeModelData> {
  final Value<int> id;
  final Value<String> queryWord;
  final Value<String> words;
  final Value<DateTime> createdAt;
  const HistoryRhymeModelCompanion({
    this.id = const Value.absent(),
    this.queryWord = const Value.absent(),
    this.words = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  HistoryRhymeModelCompanion.insert({
    this.id = const Value.absent(),
    required String queryWord,
    required String words,
    required DateTime createdAt,
  })  : queryWord = Value(queryWord),
        words = Value(words),
        createdAt = Value(createdAt);
  static Insertable<HistoryRhymeModelData> custom({
    Expression<int>? id,
    Expression<String>? queryWord,
    Expression<String>? words,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (queryWord != null) 'query_word': queryWord,
      if (words != null) 'words': words,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  HistoryRhymeModelCompanion copyWith(
      {Value<int>? id,
      Value<String>? queryWord,
      Value<String>? words,
      Value<DateTime>? createdAt}) {
    return HistoryRhymeModelCompanion(
      id: id ?? this.id,
      queryWord: queryWord ?? this.queryWord,
      words: words ?? this.words,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (queryWord.present) {
      map['query_word'] = Variable<String>(queryWord.value);
    }
    if (words.present) {
      map['words'] = Variable<String>(words.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HistoryRhymeModelCompanion(')
          ..write('id: $id, ')
          ..write('queryWord: $queryWord, ')
          ..write('words: $words, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $FavoriteRhymeModelTable favoriteRhymeModel =
      $FavoriteRhymeModelTable(this);
  late final $HistoryRhymeModelTable historyRhymeModel =
      $HistoryRhymeModelTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [favoriteRhymeModel, historyRhymeModel];
}

typedef $$FavoriteRhymeModelTableCreateCompanionBuilder
    = FavoriteRhymeModelCompanion Function({
  Value<int> id,
  required String queryWord,
  required String favoriteWord,
  required String words,
  required DateTime createdAt,
});
typedef $$FavoriteRhymeModelTableUpdateCompanionBuilder
    = FavoriteRhymeModelCompanion Function({
  Value<int> id,
  Value<String> queryWord,
  Value<String> favoriteWord,
  Value<String> words,
  Value<DateTime> createdAt,
});

class $$FavoriteRhymeModelTableFilterComposer
    extends FilterComposer<_$AppDatabase, $FavoriteRhymeModelTable> {
  $$FavoriteRhymeModelTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get queryWord => $state.composableBuilder(
      column: $state.table.queryWord,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get favoriteWord => $state.composableBuilder(
      column: $state.table.favoriteWord,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get words => $state.composableBuilder(
      column: $state.table.words,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$FavoriteRhymeModelTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $FavoriteRhymeModelTable> {
  $$FavoriteRhymeModelTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get queryWord => $state.composableBuilder(
      column: $state.table.queryWord,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get favoriteWord => $state.composableBuilder(
      column: $state.table.favoriteWord,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get words => $state.composableBuilder(
      column: $state.table.words,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $$FavoriteRhymeModelTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FavoriteRhymeModelTable,
    FavoriteRhymeModelData,
    $$FavoriteRhymeModelTableFilterComposer,
    $$FavoriteRhymeModelTableOrderingComposer,
    $$FavoriteRhymeModelTableCreateCompanionBuilder,
    $$FavoriteRhymeModelTableUpdateCompanionBuilder,
    (
      FavoriteRhymeModelData,
      BaseReferences<_$AppDatabase, $FavoriteRhymeModelTable,
          FavoriteRhymeModelData>
    ),
    FavoriteRhymeModelData,
    PrefetchHooks Function()> {
  $$FavoriteRhymeModelTableTableManager(
      _$AppDatabase db, $FavoriteRhymeModelTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$FavoriteRhymeModelTableFilterComposer(ComposerState(db, table)),
          orderingComposer: $$FavoriteRhymeModelTableOrderingComposer(
              ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> queryWord = const Value.absent(),
            Value<String> favoriteWord = const Value.absent(),
            Value<String> words = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              FavoriteRhymeModelCompanion(
            id: id,
            queryWord: queryWord,
            favoriteWord: favoriteWord,
            words: words,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String queryWord,
            required String favoriteWord,
            required String words,
            required DateTime createdAt,
          }) =>
              FavoriteRhymeModelCompanion.insert(
            id: id,
            queryWord: queryWord,
            favoriteWord: favoriteWord,
            words: words,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$FavoriteRhymeModelTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FavoriteRhymeModelTable,
    FavoriteRhymeModelData,
    $$FavoriteRhymeModelTableFilterComposer,
    $$FavoriteRhymeModelTableOrderingComposer,
    $$FavoriteRhymeModelTableCreateCompanionBuilder,
    $$FavoriteRhymeModelTableUpdateCompanionBuilder,
    (
      FavoriteRhymeModelData,
      BaseReferences<_$AppDatabase, $FavoriteRhymeModelTable,
          FavoriteRhymeModelData>
    ),
    FavoriteRhymeModelData,
    PrefetchHooks Function()>;
typedef $$HistoryRhymeModelTableCreateCompanionBuilder
    = HistoryRhymeModelCompanion Function({
  Value<int> id,
  required String queryWord,
  required String words,
  required DateTime createdAt,
});
typedef $$HistoryRhymeModelTableUpdateCompanionBuilder
    = HistoryRhymeModelCompanion Function({
  Value<int> id,
  Value<String> queryWord,
  Value<String> words,
  Value<DateTime> createdAt,
});

class $$HistoryRhymeModelTableFilterComposer
    extends FilterComposer<_$AppDatabase, $HistoryRhymeModelTable> {
  $$HistoryRhymeModelTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get queryWord => $state.composableBuilder(
      column: $state.table.queryWord,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get words => $state.composableBuilder(
      column: $state.table.words,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$HistoryRhymeModelTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $HistoryRhymeModelTable> {
  $$HistoryRhymeModelTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get queryWord => $state.composableBuilder(
      column: $state.table.queryWord,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get words => $state.composableBuilder(
      column: $state.table.words,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $$HistoryRhymeModelTableTableManager extends RootTableManager<
    _$AppDatabase,
    $HistoryRhymeModelTable,
    HistoryRhymeModelData,
    $$HistoryRhymeModelTableFilterComposer,
    $$HistoryRhymeModelTableOrderingComposer,
    $$HistoryRhymeModelTableCreateCompanionBuilder,
    $$HistoryRhymeModelTableUpdateCompanionBuilder,
    (
      HistoryRhymeModelData,
      BaseReferences<_$AppDatabase, $HistoryRhymeModelTable,
          HistoryRhymeModelData>
    ),
    HistoryRhymeModelData,
    PrefetchHooks Function()> {
  $$HistoryRhymeModelTableTableManager(
      _$AppDatabase db, $HistoryRhymeModelTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$HistoryRhymeModelTableFilterComposer(ComposerState(db, table)),
          orderingComposer: $$HistoryRhymeModelTableOrderingComposer(
              ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> queryWord = const Value.absent(),
            Value<String> words = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              HistoryRhymeModelCompanion(
            id: id,
            queryWord: queryWord,
            words: words,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String queryWord,
            required String words,
            required DateTime createdAt,
          }) =>
              HistoryRhymeModelCompanion.insert(
            id: id,
            queryWord: queryWord,
            words: words,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$HistoryRhymeModelTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $HistoryRhymeModelTable,
    HistoryRhymeModelData,
    $$HistoryRhymeModelTableFilterComposer,
    $$HistoryRhymeModelTableOrderingComposer,
    $$HistoryRhymeModelTableCreateCompanionBuilder,
    $$HistoryRhymeModelTableUpdateCompanionBuilder,
    (
      HistoryRhymeModelData,
      BaseReferences<_$AppDatabase, $HistoryRhymeModelTable,
          HistoryRhymeModelData>
    ),
    HistoryRhymeModelData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$FavoriteRhymeModelTableTableManager get favoriteRhymeModel =>
      $$FavoriteRhymeModelTableTableManager(_db, _db.favoriteRhymeModel);
  $$HistoryRhymeModelTableTableManager get historyRhymeModel =>
      $$HistoryRhymeModelTableTableManager(_db, _db.historyRhymeModel);
}
