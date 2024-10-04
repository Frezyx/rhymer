// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_rhymes.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class FavoriteRhymes extends _FavoriteRhymes
    with RealmEntity, RealmObjectBase, RealmObject {
  FavoriteRhymes(
    String id,
    String queryWord,
    String favoriteWord,
    DateTime createdAt, {
    Iterable<String> words = const [],
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'queryWord', queryWord);
    RealmObjectBase.set(this, 'favoriteWord', favoriteWord);
    RealmObjectBase.set(this, 'createdAt', createdAt);
    RealmObjectBase.set<RealmList<String>>(
        this, 'words', RealmList<String>(words));
  }

  FavoriteRhymes._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get queryWord =>
      RealmObjectBase.get<String>(this, 'queryWord') as String;
  @override
  set queryWord(String value) => RealmObjectBase.set(this, 'queryWord', value);

  @override
  String get favoriteWord =>
      RealmObjectBase.get<String>(this, 'favoriteWord') as String;
  @override
  set favoriteWord(String value) =>
      RealmObjectBase.set(this, 'favoriteWord', value);

  @override
  DateTime get createdAt =>
      RealmObjectBase.get<DateTime>(this, 'createdAt') as DateTime;
  @override
  set createdAt(DateTime value) =>
      RealmObjectBase.set(this, 'createdAt', value);

  @override
  RealmList<String> get words =>
      RealmObjectBase.get<String>(this, 'words') as RealmList<String>;
  @override
  set words(covariant RealmList<String> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<FavoriteRhymes>> get changes =>
      RealmObjectBase.getChanges<FavoriteRhymes>(this);

  @override
  FavoriteRhymes freeze() => RealmObjectBase.freezeObject<FavoriteRhymes>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(FavoriteRhymes._);
    return SchemaObject(
        ObjectType.realmObject, FavoriteRhymes, 'FavoriteRhymes', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('queryWord', RealmPropertyType.string),
      SchemaProperty('favoriteWord', RealmPropertyType.string),
      SchemaProperty('createdAt', RealmPropertyType.timestamp),
      SchemaProperty('words', RealmPropertyType.string,
          collectionType: RealmCollectionType.list),
    ]);
  }
}
