import 'package:rhymer/api/api.dart';
import 'package:rhymer/api/models/models.dart';
import 'package:rhymer/repositories/rhymes/rhymes.dart';

class RhymesRepository implements RhymesRepositoryI {
  RhymesRepository({required this.apiClient});

  final RhymerApiClient apiClient;

  @override
  Future<RhymesDto> fetchRhymesList(String word) async {
    final data = await apiClient.getRhymesList(word);
    return data;
  }
}
