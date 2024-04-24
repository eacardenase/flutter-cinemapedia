import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/local_database_repository.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';

class _FavoriteMoviesNotifier extends StateNotifier<Map<int, Movie>> {
  int page = 0;
  final LocalDatabaseRepository localDatabaseRepository;

  _FavoriteMoviesNotifier({
    required this.localDatabaseRepository,
  }) : super({});

  Future<List<Movie>> loadNextPage() async {
    final movies = await localDatabaseRepository.loadMovies(offset: page * 10);
    final tempMoviesMap = {};

    page++;

    for (var movie in movies) {
      tempMoviesMap[movie.id] = movie;
    }

    state = {
      ...state,
      ...tempMoviesMap,
    };

    return movies;
  }
}

final favoriteMoviesProvider =
    StateNotifierProvider<_FavoriteMoviesNotifier, Map<int, Movie>>(
  (ref) => _FavoriteMoviesNotifier(
    localDatabaseRepository: ref.watch(localDatabaseRepositoryProvider),
  ),
);
