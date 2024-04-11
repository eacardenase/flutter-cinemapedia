import 'package:flutter/material.dart';

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
      height: 150,
      child: Column(
        children: [
          if (title != null && subtitle != null)
            _Title(
              title: title!,
              subtitle: subtitle!,
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
    final subtitleStyle = Theme.of(context).textTheme.titleMedium;

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
              style: subtitleStyle,
            ),
          ),
        ],
      ),
    );
  }
}
