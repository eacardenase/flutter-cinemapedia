import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_details.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_moviedb.dart';

class MovieMapper {
  MovieMapper._();

  static Movie movieDBToEntity(MovieMovieDB moviedb) => Movie(
        adult: moviedb.adult,
        backdropPath: 'https://image.tmdb.org/t/p/w500${moviedb.backdropPath}',
        genreIds: moviedb.genreIds.map((id) => id.toString()).toList(),
        id: moviedb.id,
        originalLanguage: moviedb.originalLanguage,
        originalTitle: moviedb.originalTitle,
        overview: moviedb.overview,
        popularity: moviedb.popularity,
        posterPath: 'https://image.tmdb.org/t/p/w500${moviedb.posterPath}',
        releaseDate: moviedb.releaseDate,
        title: moviedb.title,
        video: moviedb.video,
        voteAverage: moviedb.voteAverage,
        voteCount: moviedb.voteCount,
      );

  static Movie movieDetailsToEntity(MovieDetails movie) => Movie(
        adult: movie.adult,
        backdropPath: 'https://image.tmdb.org/t/p/w500${movie.backdropPath}',
        genreIds: movie.genres.map((genre) => genre.name).toList(),
        id: movie.id,
        originalLanguage: movie.originalLanguage,
        originalTitle: movie.originalTitle,
        overview: movie.overview,
        popularity: movie.popularity,
        posterPath: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
        releaseDate: movie.releaseDate,
        title: movie.title,
        video: movie.video,
        voteAverage: movie.voteAverage,
        voteCount: movie.voteCount,
      );
}
