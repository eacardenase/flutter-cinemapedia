import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';

typedef GetMovieCallback = Future<Movie> Function(String movieId);

class MoviesMapNotifier extends StateNotifier<Map<String, Movie>> {
  final GetMovieCallback getMovie;

  MoviesMapNotifier({
    required this.getMovie,
  }) : super({});

  Future<void> loadMovie(String movieId) async {
    if (state[movieId] != null) return;

    final movie = await getMovie(movieId);

    state = {
      ...state,
      movieId: movie,
    };
  }
}

final movieDetailProvider =
    StateNotifierProvider<MoviesMapNotifier, Map<String, Movie>>((ref) {
  final getMovie = ref.watch(movieRepositoryProvider).getMovieById;

  return MoviesMapNotifier(
    getMovie: getMovie,
  );
});
