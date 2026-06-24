import '../../../workout_history/domain/models/workout_record.dart';
import '../../../active_workout/domain/models/set_log.dart';
import 'dart:convert';

class WorkoutSummary {
  final int totalWorkoutsCompleted;
  final int totalTrainingMinutes;
  final double totalVolumeLiftedKg;
  final Map<String, int> focusGroupDistribution; // e.g., {"CHEST": 4, "BICEPS": 2}

  const WorkoutSummary({
    required this.totalWorkoutsCompleted,
    required this.totalTrainingMinutes,
    required this.totalVolumeLiftedKg,
    required this.focusGroupDistribution,
  });

  /// Factory constructor that scans all raw Isar history entries and outputs aggregated statistics
  factory WorkoutSummary.fromHistoryRecords(List<WorkoutRecord> records) {
    int totalMinutes = 0;
    double totalVolume = 0.0;
    final Map<String, int> distribution = {};

    for (var record in records) {
      totalMinutes += record.durationMinutes;
      
      // Update targeted focus distribution counts safely
      final group = record.focusGroup.toUpperCase();
      distribution[group] = (distribution[group] ?? 0) + 1;

      // Unpack serialized JSON elements to tally total weight volume moved across history
      for (var jsonStr in record.loggedExercisesJson) {
        try {
          final Map<String, dynamic> exerciseMap = jsonDecode(jsonStr);
          final List<dynamic> setsRaw = exerciseMap['sets'] ?? [];
          
          for (var setRaw in setsRaw) {
            final setLog = SetLog.fromMap(Map<String, dynamic>.from(setRaw));
            totalVolume += (setLog.weight * setLog.reps);
          }
        } catch (e) {
          // Gracefully skip corrupt rows or structural json parse exceptions
          print('Skipping summary volume parse item block: $e');
        }
      }
    }

    return WorkoutSummary(
      totalWorkoutsCompleted: records.length,
      totalTrainingMinutes: totalMinutes,
      totalVolumeLiftedKg: totalVolume,
      focusGroupDistribution: distribution,
    );
  }

  /// Generates an empty summary placeholder object if no logs exist yet on a new device installation
  factory WorkoutSummary.empty() {
    return const WorkoutSummary(
      totalWorkoutsCompleted: 0,
      totalTrainingMinutes: 0,
      totalVolumeLiftedKg: 0.0,
      focusGroupDistribution: {},
    );
  }
}