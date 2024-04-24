import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'package:cinemapedia/domain/datasources/local_database_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

class IsarDatabaseDatasource extends LocalDatabaseDatasource {
  late Future<Isar> db;

  IsarDatabaseDatasource() {
    db = _openDb();
  }

  @override
  Future<bool> isFavorite(int movieId) {
    throw UnimplementedError();
  }

  @override
  Future<void> toggleFavorite(Movie movie) {
    throw UnimplementedError();
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) {
    throw UnimplementedError();
  }

  Future<Isar> _openDb() async {
    final dir = await getApplicationDocumentsDirectory();

    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [MovieSchema],
        directory: dir.path,
        inspector: true,
      );
    }

    return Future.value(Isar.getInstance());
  }
}
