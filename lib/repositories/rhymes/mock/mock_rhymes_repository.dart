import 'dart:math';

import 'package:rhymer/api/models/rhymes.dart';
import 'package:rhymer/repositories/rhymes/rhymes.dart';

class MockRhymesRepository implements RhymesRepositoryI {
  @override
  Future<Rhymes> fetchRhymesList(String rhyme) async {
    await Future.delayed(
      Duration(seconds: (Random().nextInt(2) - Random().nextInt(1)).abs()),
    );
    return Rhymes(
      words: List.generate(
        20,
        (index) => Random().nextInt(100000000).hashCode.toString(),
      ),
    );
  }
}
