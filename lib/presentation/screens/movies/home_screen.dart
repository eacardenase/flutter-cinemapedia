import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home_screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  ConsumerState<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);

    final slideshowMovies = ref.watch(moviesSlideshowProvider);

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppBar(),
            titlePadding: EdgeInsets.zero,
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: 1,
            (context, index) => Column(
              children: [
                MoviesSlideshow(
                  movies: slideshowMovies,
                ),
                MovieHorizontalListView(
                  movies: nowPlayingMovies,
                  title: 'In Theaters',
                  subtitle: 'Monday 20th',
                  loadNextPage:
                      ref.read(nowPlayingMoviesProvider.notifier).loadNextPage,
                ),
                MovieHorizontalListView(
                  movies: upcomingMovies,
                  title: 'Soon',
                  subtitle: 'This month',
                  loadNextPage:
                      ref.read(upcomingMoviesProvider.notifier).loadNextPage,
                ),
                MovieHorizontalListView(
                  movies: popularMovies,
                  title: 'Popular',
                  subtitle: 'This month',
                  loadNextPage:
                      ref.read(popularMoviesProvider.notifier).loadNextPage,
                ),
                const SizedBox(height: 10)
              ],
            ),
          ),
        )
      ],
    );
  }
}
