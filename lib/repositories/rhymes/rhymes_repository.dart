// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:rhymer/api/api.dart';
import 'package:rhymer/api/models/rhymes.dart';
import 'package:rhymer/repositories/rhymes/rhymes.dart';

class RhymesRepository implements RhymesRepositoryI {
  RhymesRepository({required this.apiClient});

  final RhymerApiClient apiClient;

  @override
  Future<Rhymes> fetchRhymesList(String word) async {
    final data = await apiClient.getRhymesList(word);
    return data;
  }
}
