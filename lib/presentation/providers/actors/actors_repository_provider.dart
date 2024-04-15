import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/infrastructure/datasources/actor_moviedb_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/actors_repository_impl.dart';

final actorsRepositoryProvider = Provider(
  (ref) => ActorsRepositoryImpl(
    datasource: ActorMovieDbDatasource(),
  ),
);
