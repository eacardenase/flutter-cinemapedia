import 'package:cinemapedia/presentation/providers/database/local_database_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isFavoriteMovieProvider =
    FutureProvider.family.autoDispose((ref, int movieId) {
  return ref.watch(localDatabaseRepositoryProvider).isFavorite(movieId);
});
