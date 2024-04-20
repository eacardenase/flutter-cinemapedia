import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';

class _SearchedMoviesNotifier extends StateNotifier<List<Movie>> {
  final Future<List<Movie>> Function(String) _searchMovies;
  final Ref ref;

  _SearchedMoviesNotifier({
    required Future<List<Movie>> Function(String) searchMovies,
    required this.ref,
  })  : _searchMovies = searchMovies,
        super([]);

  Future<List<Movie>> searchMoviesByQuery(String query) async {
    final List<Movie> movies = await _searchMovies(query);

    state = movies;
    ref.read(searchQueryProvider.notifier).update((state) => query);

    return movies;
  }
}

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchedMoviesProvider =
    StateNotifierProvider<_SearchedMoviesNotifier, List<Movie>>(
  (ref) => _SearchedMoviesNotifier(
    searchMovies: ref.read(movieRepositoryProvider).searchMovies,
    ref: ref,
  ),
);
