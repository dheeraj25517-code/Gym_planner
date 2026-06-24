import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../../../../core/database/isar_service.dart';
import '../../../active_workout/domain/models/workout_session.dart';
import '../../domain/models/workout_record.dart';

class HistoryController extends StateNotifier<List<WorkoutRecord>> {
  HistoryController() : super([]) {
    fetchHistoryRecords(); // Automatically loads all saved entries on startup
  }

  /// Pulls logs from the Isar instance database ordered chronologically
  Future<void> fetchHistoryRecords() async {
    final isar = IsarService.instance.db;
    final records = await isar.workoutRecords.where().sortByTimestampDesc().findAll();
    state = records;
  }

  /// Serializes active tracking memory data and commits it permanently to disk
  Future<void> saveWorkoutSessionRecord({
    required WorkoutSession session,
    required int performanceRating,
    required String muscleNotes,
    required String generalComments,
  }) async {
    final isar = IsarService.instance.db;

    final List<String> serializedExercises = [];

    // Map your in-memory Map structural sets data into standard JSON rows
    session.exercisesLog.forEach((exerciseName, setsList) {
      final Map<String, dynamic> exerciseMap = {
        'name': exerciseName,
        'sets': setsList.map((setLog) => setLog.toMap()).toList(),
      };
      serializedExercises.add(jsonEncode(exerciseMap));
    });

    final newRecord = WorkoutRecord()
      ..timestamp = DateTime.now()
      ..focusGroup = session.focusGroup
      ..durationMinutes = session.durationMinutes
      ..performanceRating = performanceRating
      ..muscleNotes = muscleNotes
      ..generalComments = generalComments
      ..loggedExercisesJson = serializedExercises;

    // Open an atomic write transaction block inside Isar to safely persist the entry
    await isar.writeTxn(() async {
      await isar.workoutRecords.put(newRecord);
    });

    // Refresh memory stream layers to update UI timelines automatically
    await fetchHistoryRecords();
  }
}

// Global provider handle to communicate with your workout ledger tables
final historyControllerProvider = StateNotifierProvider<HistoryController, List<WorkoutRecord>>((ref) {
  return HistoryController();
});