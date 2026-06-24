import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../../features/workout_setup/domain/models/exercise.dart';
import '../../features/workout_history/domain/models/workout_record.dart';

class IsarService {
  static IsarService? _instance;
  late final Isar _isarInstance;

  IsarService._();

  static IsarService get instance => _instance ??= IsarService._();
  
  Isar get db => _isarInstance;

  /// Initializes Isar database storage paths natively on iOS/Android device systems
  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    
    _isarInstance = await Isar.open(
      [
        ExerciseSchema,
        WorkoutRecordSchema,
      ],
      directory: dir.path,
    );
  }
}