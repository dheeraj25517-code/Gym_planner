import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/workout_session.dart';
import '../../domain/models/set_log.dart';

class ActiveWorkoutController extends StateNotifier<WorkoutSession?> {
  ActiveWorkoutController() : super(null);

  /// Initializes the live operational tracker layout for target chosen movements
  void beginNewWorkoutSession(String focusGroup, List<String> selectedExercises) {
    final Map<String, List<SetLog>> initialMap = {};

    for (var exercise in selectedExercises) {
      // Anchors every movement with an explicit default Set 1 entry automatically
      initialMap[exercise] = [
        const SetLog(setNumber: 1, weight: -1.0, reps: -1, type: 'EXACT'),
      ];
    }

    state = WorkoutSession(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      focusGroup: focusGroup.toUpperCase(),
      startTime: DateTime.now(),
      exercisesLog: initialMap,
    );
  }

  /// Appends an additional line set configuration duplicating previous inputs
  void addSetToExercise(String exerciseName) {
    if (state == null) return;

    final currentLog = Map<String, List<SetLog>>.from(state!.exercisesLog);
    final targetSets = List<SetLog>.from(currentLog[exerciseName] ?? []);

    if (targetSets.isNotEmpty) {
      final lastSet = targetSets.last;
      targetSets.add(SetLog(
        setNumber: targetSets.length + 1,
        weight: lastSet.weight,
        reps: lastSet.reps,
        type: lastSet.type,
      ));
    } else {
      targetSets.add(const SetLog(setNumber: 1, weight: 60.0, reps: 10));
    }

    currentLog[exerciseName] = targetSets;
    state = state!.copyWith(exercisesLog: currentLog);
  }

  /// Truncates a targeted item row configuration out of an exercise set block
  void removeSetFromExercise(String exerciseName, int index) {
    if (state == null) return;

    final currentLog = Map<String, List<SetLog>>.from(state!.exercisesLog);
    final targetSets = List<SetLog>.from(currentLog[exerciseName] ?? []);

    if (targetSets.length > 1) {
      targetSets.removeAt(index);
      
      // Remaps index counting parameters incrementally to stay visually sequential
      final reindexedSets = List<SetLog>.generate(targetSets.length, (i) {
        return targetSets[i].copyWith(setNumber: i + 1);
      });

      currentLog[exerciseName] = reindexedSets;
      state = state!.copyWith(exercisesLog: currentLog);
    }
  }

  /// Modifies lifting metrics inline as text changes on input configurations
  void updateInlineSetMetrics(String exerciseName, int index, {double? weight, int? reps, String? type}) {
    if (state == null) return;

    final currentLog = Map<String, List<SetLog>>.from(state!.exercisesLog);
    final targetSets = List<SetLog>.from(currentLog[exerciseName] ?? []);

    if (index >= 0 && index < targetSets.length) {
      targetSets[index] = targetSets[index].copyWith(
        weight: weight ?? targetSets[index].weight,
        reps: reps ?? targetSets[index].reps,
        type: type ?? targetSets[index].type,
      );

      currentLog[exerciseName] = targetSets;
      state = state!.copyWith(exercisesLog: currentLog);
    }
  }

  /// Stops performance track records and timestamps closing indicators
  void finalizeSession() {
    if (state == null) return;
    state = state!.copyWith(endTime: DateTime.now());
  }

  /// Completely purges structural active memories to free hardware channels
  void clearActiveSession() {
    state = null;
  }
}

// Global hook provider to watch, handle, and change tracking details from widgets
final activeWorkoutControllerProvider = StateNotifierProvider<ActiveWorkoutController, WorkoutSession?>((ref) {
  return ActiveWorkoutController();
});