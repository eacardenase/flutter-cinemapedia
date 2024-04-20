import 'dart:async';

import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';

import 'package:cinemapedia/domain/entities/movie.dart';

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  Timer? _debounceTimer;
  final Future<List<Movie>> Function(String) _onSearchMovies;
  List<Movie> _initialMovies;
  final StreamController<List<Movie>> _debouncedMovies =
      StreamController.broadcast();
  final StreamController<bool> _isLoadingStream = StreamController.broadcast();

  SearchMovieDelegate({
    required Future<List<Movie>> Function(String) onSearchMovies,
    List<Movie> initialMovies = const [],
  })  : _initialMovies = initialMovies,
        _onSearchMovies = onSearchMovies,
        super(
          textInputAction: TextInputAction.search,
        );

  @override
  String get searchFieldLabel => 'Search movie';

  void _onQueryChanged(String query) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _isLoadingStream.add(true);

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      final movies = await _onSearchMovies(query);
      _initialMovies = movies;

      _debouncedMovies.add(movies);
      _isLoadingStream.add(false);
    });
  }

  Widget _buildQueryResults() {
    return StreamBuilder(
      stream: _debouncedMovies.stream,
      initialData: _initialMovies,
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];

            return _MovieSearchItem(
              movie: movie,
              onMovieSelected: (context, movie) {
                _clearStreams();

                close(context, movie);
              },
            );
          },
        );
      },
    );
  }

  void _clearStreams() {
    _debouncedMovies.close();
    _isLoadingStream.close();
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      StreamBuilder(
        stream: _isLoadingStream.stream,
        builder: (context, snapshot) {
          final isLoading = snapshot.data ?? false;

          if (isLoading) {
            return Visibility(
              visible: query.isNotEmpty,
              child: SpinPerfect(
                duration: const Duration(seconds: 2),
                infinite: true,
                child: IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.refresh,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            );
          }

          return FadeIn(
            animate: query.isNotEmpty,
            child: IconButton(
              onPressed: () => query = '',
              icon: Icon(
                Icons.clear,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          );
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        _clearStreams();

        close(context, null);
      },
      icon: Icon(
        Icons.chevron_left,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildQueryResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);

    return _buildQueryResults();
  }
}

class _MovieSearchItem extends StatelessWidget {
  final Movie movie;
  final void Function(BuildContext, Movie?) onMovieSelected;

  const _MovieSearchItem({
    required this.movie,
    required this.onMovieSelected,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => onMovieSelected(context, movie),
      child: SizedBox(
        height: 150,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              SizedBox(
                height: double.infinity,
                width: size.width * 0.25,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    movie.posterPath,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) => FadeIn(
                      child: child,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // Movie Desc
              SizedBox(
                width: size.width * 0.65,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      movie.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.titleMedium,
                    ),
                    Text(
                      movie.overview,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyMedium,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star_half_outlined,
                          color: Colors.yellow.shade800,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          movie.voteAverage.toStringAsFixed(1),
                          style: textTheme.bodyMedium?.copyWith(
                            color: Colors.yellow.shade900,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
