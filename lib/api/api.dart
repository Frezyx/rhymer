import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:rhymer/api/models/models.dart';
import 'package:talker/talker.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

part 'api.g.dart';

@RestApi(baseUrl: '')
abstract class RhymerApiClient {
  factory RhymerApiClient(Dio dio, {String baseUrl}) = _RhymerApiClient;

  factory RhymerApiClient.create({String? apiUrl, Talker? talker}) {
    final dio = Dio();
    dio.interceptors.addAll([TalkerDioLogger(talker: talker)]);
    if (apiUrl != null) {
      return RhymerApiClient(dio, baseUrl: apiUrl);
    }
    return RhymerApiClient(dio);
  }

  @GET('/rhymes/get')
  Future<Rhymes> getRhymesList(@Query('word') String word);
}
