import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/infrastructure/datasources/isar_database_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/local_database_repository_impl.dart';

final localDatabaseRepositoryProvider = Provider(
  (ref) => LocalDatabaseRepositoryImpl(datasource: IsarDatabaseDatasource()),
);
