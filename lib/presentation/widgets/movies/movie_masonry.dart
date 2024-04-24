import 'package:flutter/material.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';

class MovieMansonry extends StatefulWidget {
  final List<Movie> movies;
  final void Function() loadNextPage;

  const MovieMansonry({
    super.key,
    required this.movies,
    required this.loadNextPage,
  });

  @override
  State<MovieMansonry> createState() => _MovieMansonryState();
}

class _MovieMansonryState extends State<MovieMansonry> {
  // TODO: initState
  // TODO: dispose

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: MasonryGridView.count(
        crossAxisCount: 3,
        itemCount: widget.movies.length,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        itemBuilder: (context, index) {
          final movie = widget.movies[index];

          if (index == 1) {
            return Column(
              children: [
                const SizedBox(height: 30),
                MoviePosterLink(
                  movie: movie,
                )
              ],
            );
          }

          return MoviePosterLink(
            movie: movie,
          );
        },
      ),
    );
  }
}
