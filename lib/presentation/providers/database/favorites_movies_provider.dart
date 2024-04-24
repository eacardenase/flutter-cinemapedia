import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/local_database_repository.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';

class _FavoriteMoviesNotifier extends StateNotifier<Map<int, Movie>> {
  int _currentPage = 0;
  final LocalDatabaseRepository _localDatabaseRepository;

  _FavoriteMoviesNotifier({
    required LocalDatabaseRepository localDatabaseRepository,
  })  : _localDatabaseRepository = localDatabaseRepository,
        super({});

  Future<List<Movie>> loadNextPage() async {
    _currentPage++;

    final movies =
        await _localDatabaseRepository.loadMovies(offset: _currentPage);

    final tempMoviesMap = {};

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
