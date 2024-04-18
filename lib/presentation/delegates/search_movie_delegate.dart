import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';

import 'package:cinemapedia/domain/entities/movie.dart';

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final Future<List<Movie>> Function(String) searchMovies;

  SearchMovieDelegate({
    required this.searchMovies,
  });

  @override
  String get searchFieldLabel => 'Search movie';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        FadeIn(
          child: IconButton(
            onPressed: () => query = '',
            icon: Icon(
              Icons.clear,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: Icon(
        Icons.chevron_left,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('Build Results');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: searchMovies(query),
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];

            return ListTile(
              title: Text(
                movie.title,
              ),
            );
          },
        );
      },
    );
  }
}
