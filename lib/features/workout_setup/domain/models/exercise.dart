import 'package:isar/isar.dart';

part 'exercise.g.dart';

@Collection()
class Exercise {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String name; 

  late String muscleGroup;    // e.g., "BICEPS"
  late String primaryMuscle;  // e.g., "BRACHIORADIALIS"

  Exercise();

  /// Automatically parses: "biceps|brachioradialis|zottman curls"
  factory Exercise.fromPipeString(String pipeLine) {
    final tokens = pipeLine.split('|').map((t) => t.trim()).toList();
    if (tokens.length < 3) {
      throw const FormatException("The data string must contain 3 structural piped parameters.");
    }

    return Exercise()
      ..muscleGroup = tokens[0].toUpperCase()
      ..primaryMuscle = tokens[1].toUpperCase()
      ..name = _formatExerciseName(tokens[2]);
  }

  static String _formatExerciseName(String input) {
    if (input.isEmpty) return input;
    return input.split(' ').map((word) {
      if (word.isEmpty) return '';
      return '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}';
    }).join(' ');
  }
}