import 'set_log.dart';

class WorkoutSession {
  final String id;
  final String focusGroup; // e.g., "BICEPS", "CHEST", "BACK"
  final DateTime startTime;
  final DateTime? endTime;
  
  // Maps specific exercise titles directly to their historical lists of logged sets
  final Map<String, List<SetLog>> exercisesLog;

  const WorkoutSession({
    required this.id,
    required this.focusGroup,
    required this.startTime,
    this.endTime,
    required this.exercisesLog,
  });

  /// Computes total session training duration dynamically in minutes
  int get durationMinutes {
    if (endTime == null) return 0;
    return endTime!.difference(startTime).inMinutes;
  }

  /// Utility to calculate aggregate accumulated tonnage weight volume moved across the session
  double get calculateTotalVolume {
    double totalVolume = 0.0;
    exercisesLog.forEach((exerciseName, setsList) {
      for (var setLog in setsList) {
        totalVolume += (setLog.weight * setLog.reps);
      }
    });
    return totalVolume;
  }

  /// Replicates state mutations smoothly for your active UI tracking streams
  WorkoutSession copyWith({
    String? id,
    String? focusGroup,
    DateTime? startTime,
    DateTime? endTime,
    Map<String, List<SetLog>>? exercisesLog,
  }) {
    return WorkoutSession(
      id: id ?? this.id,
      focusGroup: focusGroup ?? this.focusGroup,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      exercisesLog: exercisesLog ?? this.exercisesLog,
    );
  }
}