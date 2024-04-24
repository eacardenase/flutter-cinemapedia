import 'package:cinemapedia/domain/datasources/local_database_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

class IsarDatabaseDatasource extends LocalDatabaseDatasource {
  @override
  Future<bool> isFavorite(int movieId) {
    throw UnimplementedError();
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) {
    throw UnimplementedError();
  }

  @override
  Future<void> toggleFavorite(Movie movie) {
    throw UnimplementedError();
  }
}
