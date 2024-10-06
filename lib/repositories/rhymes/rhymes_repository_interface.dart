import 'package:rhymer/api/models/rhymes.dart';

abstract interface class RhymesRepositoryI {
  Future<Rhymes> fetchRhymesList(String rhyme);
}
