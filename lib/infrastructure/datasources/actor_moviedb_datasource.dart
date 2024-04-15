import 'package:dio/dio.dart';

import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/mappers/actor_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credits_response.dart';

class ActorMovieDbDatasource extends ActorsDatasource {
  final _dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3/',
      queryParameters: {
        'api_key': Environment.theMovieDbKey,
      },
    ),
  );

  @override
  Future<List<Actor>> getActorsByMovieId(String id) async {
    final response = await _dio.get('movie/$id/credits');
    final creditsRespone = CreditsResponse.fromJson(response.data);
    final List<Actor> actors = creditsRespone.cast
        .map((cast) => ActorMapper.castToEntity(cast))
        .toList();

    return actors;
  }
}
