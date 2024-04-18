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
          itemBuilder: (context, index) => _MovieSearchItem(
            movie: movies[index],
          ),
        );
      },
    );
  }
}

class _MovieSearchItem extends StatelessWidget {
  final Movie movie;

  const _MovieSearchItem({
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
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
    );
  }
}
