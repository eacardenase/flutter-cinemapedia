import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';

import 'package:cinemapedia/domain/entities/movie.dart';

class MovieHorizontalListView extends StatelessWidget {
  final List<Movie> movies;
  final String? title;
  final String? subtitle;
  final void Function()? loadNextPage;

  const MovieHorizontalListView({
    super.key,
    required this.movies,
    this.title,
    this.subtitle,
    this.loadNextPage,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          if (title != null && subtitle != null)
            _Title(
              title: title!,
              subtitle: subtitle!,
            ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: movies.length,
              itemBuilder: (context, index) => _Slide(movie: movies[index]),
            ),
          )
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String title;
  final String subtitle;

  const _Title({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: titleStyle,
          ),
          FilledButton.tonal(
            style: const ButtonStyle(visualDensity: VisualDensity.compact),
            onPressed: () {},
            child: Text(
              subtitle,
            ),
          ),
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  const _Slide({
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SizedBox(
              width: 150,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  20,
                ),
                child: Image.network(
                  movie.posterPath,
                  width: 150,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress != null) {
                      return Container(
                        color: Colors.black12,
                        alignment: Alignment.center,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          ),
                        ),
                      );
                    }

                    return FadeIn(
                      child: child,
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 3),

          // Title
          SizedBox(
            width: 150,
            child: Text(
              movie.title,
              maxLines: 1,
              style: textStyles.titleSmall,
              // textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // Rating
          Row(
            children: [
              Icon(
                Icons.star_half_outlined,
                color: Colors.yellow.shade800,
              ),
              const SizedBox(width: 3),
              Text(
                movie.voteAverage.toStringAsFixed(1),
                style: textStyles.bodyMedium
                    ?.copyWith(color: Colors.yellow.shade800),
              ),
              const SizedBox(width: 3),
              Text(
                movie.popularity.toString(),
                style: textStyles.bodyMedium,
              )
            ],
          )
        ],
      ),
    );
  }
}
