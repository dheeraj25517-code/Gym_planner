import 'package:isar/isar.dart';
import 'isar_service.dart';
import '../../features/workout_setup/domain/models/exercise.dart';

class DataSeeder {
  
  // Your explicit text format list structure
  static const List<String> rawExerciseDataset = [
    'biceps|long head|inclined curls',
    'biceps|short head|preacher curls',
    'core|upper abs|crunches',
    'core|lower abs|hanging leg raises',
    'core|internal oblique|russian twists',
    'chest|upper chest|incline dumbbell bench press',
    'chest|mid chest|flat barbell bench press',
    'chest|lower chest|chest dips',
    'chest|mid chest|cable crossovers',
    'biceps|brachioradialis|hammer curls',
    'biceps|long head|drag curls',
    'biceps|long head|close grip barbell curls',
    'biceps|short head|spider curls',
    'biceps|long head|bayesian cable curls',
    'biceps|short head|preacher curls',
    'biceps|short head|wide grip curls',
    'biceps|short head|concentration curls',
    'back|lats|wide grip lat pulldowns',
    'back|upper back|seated cable rows',
    'back|lower back|barbell deadlifts',
    'back|traps|dumbbell shrugs',
    'back|lats|close grip lat pulldowns',
    'biceps|brachioradialis|reverse barbell curls',
    'forearms|flexors|seated wrist curls',
    'forearms|extensors|behind the back wrist curls',
    'legs|quads|barbell back squat',
    'legs|quads|front squat',
    'legs|quads|leg press',
    'legs|quads|duck walk',
    'legs|quads|bulgarian split squat',
    'legs|quads|walking lunges',
    'legs|quads|leg extensions',
    'legs|hamstrings|romanian deadlift',
    'legs|hamstrings|seated leg curl',
    'legs|hamstrings|single leg romanian deadlift',
    'legs|glutes|glute bridge',
    'legs|glutes|sumo deadlift',
    'legs|inner thighs|sumo squat',
    'legs|inner thighs|lateral lunges',
    'legs|inner thighs|wide stance leg press',
    'legs|outer thighs|cable hip abduction',
    'legs|outer thighs|banded lateral walks',
    'legs|outer thighs|side lying leg raises',
    'legs|calves|seated calf raises',
    'legs|calves|dumbbell standing calf raises',
    'biceps|brachioradialis|reverse barbell curls',
    'biceps|brachioradialis|reverse cable curls',
    'biceps|brachioradialis|zottman curls',
    'chest|mid chest|machine chest flys',
    'chest|upper chest|inclined bench press',
    'chest|lower chest|declined bench press',
    'shoulders|front delts|Barbell Overhead Press',
    'shoulders|front delts|Seated Dumbbell Shoulder Press',
    'shoulders|front delts|Arnold Press',
    'shoulders|front delts|Dumbbell Front Raise',
    'shoulders|front delts|Landmine Press',
    'shoulders|side delts|Dumbbell Lateral Raise',
    'shoulders|side delts|Cable Lateral Raise',
    'shoulders|side delts|Machine Lateral Raise',
    'shoulders|side delts|Lean-Away Cable Lateral Raise',
    'shoulders|side delts|Wide-Grip Upright Row',
    'shoulders|rear delts|Reverse Pec Deck Fly',
    'shoulders|rear delts|Bent-Over Rear Delt Fly',
    'shoulders|rear delts|Cable Rear Delt Fly',
    'shoulders|rear delts|Face Pull',
    'shoulders|rear delts|Rear Delt Row',
    'shoulders|rotator cuff|Band External Rotation',
    'shoulders|rotator cuff|Cable External Rotation',
    'shoulders|rotator cuff|Side-Lying External Rotation',
    'shoulders|rotator cuff|Face Pull with External Rotation',
    'shoulders|rotator cuff|Cuban Press',

    'shoulders|upper traps|Barbell Shrug',
    'shoulders|upper traps|Dumbbell Shrug',
    'shoulders|upper traps|Trap Bar Shrug',
    'shoulders|upper traps|Farmers Carry',
    'shoulders|upper traps|Behind-the-Back Shrug',

    'shoulders|mid traps|Chest-Supported Row',
    'shoulders|mid traps|Seated Cable Row',
    'shoulders|mid traps|Face Pull',
    'shoulders|mid traps|Band Pull-Apart',
    'shoulders|mid traps|Prone T Raise',

    'shoulders|lower traps|Prone Y Raise',
    'shoulders|lower traps|Trap-3 Raise',
    'shoulders|lower traps|Scapular Pull-Up',
    'shoulders|lower traps|Wall Slide with Lift-Off',
    'shoulders|lower traps|Overhead Shrug',

    'shoulders|serratus|Push-Up Plus',
    'shoulders|serratus|Cable Serratus Punch',
    'shoulders|serratus|Dynamic Hug',
    'shoulders|serratus|Wall Slide',
    'shoulders|serratus|Ab Wheel Rollout',

    'shoulders|rhomboids|Chest-Supported Row',
    'shoulders|rhomboids|Seated Cable Row',
    'shoulders|rhomboids|Face Pull',
    'shoulders|rhomboids|Band Pull-Apart',
    'shoulders|rhomboids|Reverse Pec Deck Fly',
    'triceps|long head|Overhead Dumbbell Triceps Extension',
    'triceps|long head|EZ-Bar Overhead Triceps Extension',
    'triceps|long head|Cable Overhead Triceps Extension',
    'triceps|long head|Single-Arm Cable Overhead Extension',
    'triceps|long head|Incline Dumbbell Triceps Extension',

    'triceps|lateral head|Cable Triceps Pushdown',
    'triceps|lateral head|Straight-Bar Triceps Pushdown',
    'triceps|lateral head|V-Bar Triceps Pushdown',
    'triceps|lateral head|Close-Grip Bench Press',
    'triceps|lateral head|Bench Dip',
    'triceps|medial head|Reverse-Grip Triceps Pushdown',
    'triceps|medial head|Underhand Cable Pushdown',
    'triceps|medial head|Diamond Push-Up',
    'triceps|medial head|Rope Triceps Pushdown',
    'triceps|medial head|Triceps Kickback',
    'triceps|triceps brachii (overall)|Skull Crusher',
    'triceps|triceps brachii (overall)|Lying EZ-Bar Triceps Extension',
    'triceps|triceps brachii (overall)|Close-Grip Bench Press',
    'triceps|triceps brachii (overall)|Weighted Dip',
    'triceps|triceps brachii (overall)|JM Press',
    'core|upper abs|Cable Crunch',
    'core|upper abs|Machine Crunch',
    'core|upper abs|Decline Crunch',
    'core|upper abs|Weighted Crunch',
    'core|upper abs|Sit-Up',

    'core|lower abs|Hanging Leg Raise',
    'core|lower abs|Hanging Knee Raise',
    'core|lower abs|Reverse Crunch',
    'core|lower abs|Lying Leg Raise',
    'core|lower abs|Dragon Flag',
    'core|obliques|Cable Woodchopper',
    'core|obliques|Russian Twist',
    'core|obliques|Side Plank',
    'core|obliques|Landmine Rotation',
    'core|obliques|Dumbbell Side Bend',

    'core|transverse abs|Plank',
    'core|transverse abs|Ab Wheel Rollout',
    'core|transverse abs|Dead Bug',
    'core|transverse abs|Body Saw',
    'core|transverse abs|Hollow Body Hold',
    'core|serratus|Push-Up Plus',
    'core|serratus|Cable Serratus Punch',
    'core|serratus|Dynamic Hug',
    'core|serratus|Wall Slide',
    'core|serratus|Ab Wheel Rollout',
    'core|erectors|Back Extension',
    'core|erectors|Roman Chair Extension',
    'core|erectors|Good Morning',
    'core|erectors|Rack Pull',
    'core|erectors|Bird Dog',
    'core|quadratus lumborum|Suitcase Carry',
    'core|quadratus lumborum|Side Plank Hip Lift',
    'core|quadratus lumborum|Single-Arm Farmers Carry',
    'core|quadratus lumborum|Cable Side Bend',
    'core|quadratus lumborum|Windmill',
    'core|deep core|Pallof Press',
    'core|deep core|Dead Bug',
    'core|deep core|Hollow Body Hold',
    'core|deep core|Bear Crawl',
    'core|deep core|Stir-the-Pot',
    // You can paste hundreds of rows right here in this exact format later
  ];

  /// Scans the exercise catalog database and populates missing items automatically
  static Future<void> seedDatabaseIfEmpty() async {
    final isar = IsarService.instance.db;
    
    final existingCount = await isar.exercises.count();
    if (existingCount > 0) return; 

    final List<Exercise> parsedList = [];
    
    for (final rawString in rawExerciseDataset) {
      try {
        final parsedExercise = Exercise.fromPipeString(rawString);
        parsedList.add(parsedExercise);
      } catch (e) {
        print('Skipping corrupt line parsing row item string line text: $e');
      }
    }

    if (parsedList.isNotEmpty) {
      await isar.writeTxn(() async {
        await isar.exercises.putAll(parsedList);
      });
      print('Database catalog setup complete using 3-tier format! Ingested ${parsedList.length} items.');
    }
  }
}