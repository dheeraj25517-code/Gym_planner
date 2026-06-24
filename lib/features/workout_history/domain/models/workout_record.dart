import 'package:isar/isar.dart';

// This binds with your Isar code generator
part 'workout_record.g.dart';

@Collection()
class WorkoutRecord {
  Id id = Isar.autoIncrement;

  late DateTime timestamp;     // Exact date and time the session was logged
  late String focusGroup;      // e.g., "BICEPS", "CHEST", "BACK"
  late int durationMinutes;    // Total duration computed from workout session tracking
  late int performanceRating;  // User rating from review sheet (1 to 5 stars)
  late String muscleNotes;     // Focus thoughts added during evaluation
  late String generalComments; // Target observations or personal focus notes

  /// Stores your entire exercise map data as a list of serialized JSON strings.
  /// Format per row: 
  /// '{"name": "Zottman Curls", "sets": [{"setNumber":1, "weight":14.0, "reps":12, "type":"EXACT"}]}'
  late List<String> loggedExercisesJson; 

  WorkoutRecord();
}