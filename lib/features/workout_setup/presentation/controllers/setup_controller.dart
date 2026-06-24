import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedExercisesProvider = StateNotifierProvider<SelectedExercisesNotifier, List<String>>(
  (ref) => SelectedExercisesNotifier(),
);

class SelectedExercisesNotifier extends StateNotifier<List<String>> {
  SelectedExercisesNotifier() : super([]);

  void setSelectedExercises(List<String> exercises) {
    state = List.unmodifiable(exercises);
  }

  void addExercise(String exercise) {
    if (!state.contains(exercise)) {
      state = List.unmodifiable([...state, exercise]);
    }
  }

  void removeExercise(String exercise) {
    state = List.unmodifiable(state.where((item) => item != exercise).toList());
  }

  void toggleExercise(String exercise) {
    if (state.contains(exercise)) {
      removeExercise(exercise);
    } else {
      addExercise(exercise);
    }
  }

  void clear() {
    state = const [];
  }
}
