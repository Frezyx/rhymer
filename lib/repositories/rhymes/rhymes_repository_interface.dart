import 'package:rhymer/api/models/models.dart';

abstract interface class RhymesRepositoryI {
  Future<RhymesDto> fetchRhymesList(String rhyme);
}
