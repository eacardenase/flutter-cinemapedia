import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static final String theMovieDbKey =
      dotenv.env['THE_MOVIE_DB_KEY'] ?? 'Failed to load .env variables';
}
