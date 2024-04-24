import 'package:cinemapedia/domain/datasources/local_database_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/local_database_repository.dart';

class LocalDatabaseRepositoryImpl extends LocalDatabaseRepository {
  final LocalDatabaseDatasource datasource;

  LocalDatabaseRepositoryImpl({
    required this.datasource,
  });

  @override
  Future<bool> isFavorite(int movieId) {
    return datasource.isFavorite(movieId);
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) {
    return datasource.loadMovies(limit: limit, offset: offset);
  }

  @override
  Future<void> toggleFavorite(Movie movie) {
    return datasource.toggleFavorite(movie);
  }
}
