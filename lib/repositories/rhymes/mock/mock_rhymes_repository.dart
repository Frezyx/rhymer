import 'dart:math';

import 'package:rhymer/api/models/rhymes.dart';
import 'package:rhymer/repositories/rhymes/rhymes.dart';

class MockRhymesRepository implements RhymesRepositoryI {
  @override
  Future<Rhymes> fetchRhymesList(String rhyme) async {
    await _mockDelay();
    return Rhymes(
      words: List.generate(
        20,
        (index) =>
            (Random(rhyme.hashCode).nextInt(10000) * (index + 1)).toString(),
      ),
    );
  }

  Future<void> _mockDelay() async {
    await Future.delayed(
      Duration(
        seconds: (Random().nextInt(2) - Random().nextInt(1)).abs(),
      ),
    );
  }
}