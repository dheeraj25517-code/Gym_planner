import 'package:flutter_riverpod/flutter_riverpod.dart';

// Simple tuple: an exercise name and which category it belongs to,
// used by SessionBuilderScreen to render the correct color dot.
class ExerciseEntry {
  final String name;
  final String category;
  const ExerciseEntry({required this.name, required this.category});
}

class CartNotifier extends StateNotifier<Map<String, List<String>>> {
  CartNotifier() : super({});

  // Add/replace exercises for a specific category.
  // Re-entering a category and confirming replaces that category's slice.
  void addExercisesFromCategory(String category, List<String> exercises) {
    state = {
      ...state,
      category: List<String>.from(exercises),
    };
  }

  // Returns exercises already selected for a given category,
  // used to pre-tick them when the sheet is reopened.
  List<String> exercisesForCategory(String category) {
    return state[category] ?? [];
  }

  // Flat list of just exercise names, in category insertion order.
  // Passed directly into ActiveWorkoutScreen.
  List<String> get allExercises =>
      state.values.expand((list) => list).toList();

  // Flat list of (name, category) pairs — used for colored dots in the cart.
  List<ExerciseEntry> get allExercisesWithCategory => [
        for (final entry in state.entries)
          for (final name in entry.value)
            ExerciseEntry(name: name, category: entry.key),
      ];

  // Remove a single exercise by name across any category.
  void removeExercise(String exerciseName) {
    state = {
      for (final entry in state.entries)
        entry.key: entry.value.where((e) => e != exerciseName).toList(),
    }..removeWhere((_, list) => list.isEmpty);
  }

  void clearCart() {
    state = {};
  }
}

final cartProvider =
    StateNotifierProvider<CartNotifier, Map<String, List<String>>>(
  (ref) => CartNotifier(),
);