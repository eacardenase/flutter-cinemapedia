import 'package:cinemapedia/domain/entities/movie.dart';

abstract class LocalDatabaseDatasource {
  Future<void> toggleFavorite(Movie movie);

  Future<bool> isFavorite(int movieId);

  Future<List<Movie>> loadMovies({
    int limit = 10,
    offset = 0,
  });
}
