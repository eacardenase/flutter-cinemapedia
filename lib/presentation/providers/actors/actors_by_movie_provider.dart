import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';

class ActorsByMovieMapNotifier extends StateNotifier<Map<String, List<Actor>>> {
  Future<List<Actor>> Function(String id) getActors;

  ActorsByMovieMapNotifier({
    required this.getActors,
  }) : super({});

  Future<void> loadActors(String id) async {
    if (state[id] != null) return;

    final actors = await getActors(id);

    state = {
      ...state,
      id: actors,
    };
  }
}

final actorsByMovieProvider =
    StateNotifierProvider<ActorsByMovieMapNotifier, Map<String, List<Actor>>>(
        (ref) {
  final getActors = ref.watch(actorsRepositoryProvider).getActorsByMovieId;

  return ActorsByMovieMapNotifier(
    getActors: getActors,
  );
});
