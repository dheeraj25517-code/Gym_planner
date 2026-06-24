import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/exercise_selection_sheet.dart';
import 'package:gym_planner/features/workout_setup/provider/cart_provider.dart';
import 'package:gym_planner/features/active_workout/presentation/screens/active_workout_screen.dart';

class SessionBuilderScreen extends ConsumerStatefulWidget {
  final String focusGroup; // The category this screen was opened from

  const SessionBuilderScreen({super.key, required this.focusGroup});

  @override
  ConsumerState<SessionBuilderScreen> createState() => _SessionBuilderScreenState();
}

class _SessionBuilderScreenState extends ConsumerState<SessionBuilderScreen> {
  int sessionDurationMinutes = 45;

  static const List<int> _durationOptions = [30, 45, 60, 75, 90];

  // Category → color dot, matching the reference images
  static const Map<String, Color> _categoryColors = {
    'BACK':       Color(0xFFFF9800),
    'CHEST':      Color(0xFFE91E63),
    'ARMS':       Color(0xFF9C27B0),
    'BICEPS':     Color(0xFF9C27B0),
    'TRICEPS':    Color(0xFF9C27B0),
    'SHOULDERS':  Color(0xFF2196F3),
    'LEGS':       Color(0xFF4CAF50),
    'CORE':       Color(0xFFFF9800),
    'CARDIO':     Color(0xFF00BCD4),
    'FOREARMS':   Color(0xFF4CAF50),
  };

  Color _colorForCategory(String category) {
    final upper = category.toUpperCase();
    for (final entry in _categoryColors.entries) {
      if (upper.contains(entry.key)) return entry.value;
    }
    return AppColors.neonCyan;
  }

  void _openExerciseSelector() {
    final alreadySelected =
        ref.read(cartProvider.notifier).exercisesForCategory(widget.focusGroup);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ExerciseSelectionSheet(
        focusGroup: widget.focusGroup,
        currentSelection: alreadySelected,
        onExercisesSelected: (List<String> exercises) {
          ref
              .read(cartProvider.notifier)
              .addExercisesFromCategory(widget.focusGroup, exercises);
        },
      ),
    );
  }

  Widget _buildDurationChip(int minutes) {
    final bool isSelected = sessionDurationMinutes == minutes;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => sessionDurationMinutes = minutes),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.neonCyan : AppColors.buttonDarkBg,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isSelected ? AppColors.neonCyan : AppColors.cardStroke,
              width: 1.2,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            '$minutes',
            style: TextStyle(
              color: isSelected ? AppColors.background : AppColors.textSecondary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartMap = ref.watch(cartProvider);
    final notifier = ref.read(cartProvider.notifier);
    final allExercises = notifier.allExercises;
    // List of (exerciseName, categoryKey) so we can show the right dot color
    final allExercisesWithCategory = notifier.allExercisesWithCategory;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,
              color: AppColors.textPrimary, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.focusGroup} SESSION',
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'CONFIGURE PLAN',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // --- Duration Selector ---
                    const Text(
                      'DURATION (MINUTES)',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: _durationOptions
                          .map((m) => _buildDurationChip(m))
                          .toList(),
                    ),
                    const SizedBox(height: 36),

                    // --- Exercises header row ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'EXERCISES (${allExercises.length})',
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ),
                        ),
                        // "+ Add Exercises" button — opens sheet for current category
                        GestureDetector(
                          onTap: _openExerciseSelector,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            decoration: BoxDecoration(
                              color: AppColors.neonCyan.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: AppColors.neonCyan, width: 1.2),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.add,
                                    color: AppColors.neonCyan, size: 16),
                                SizedBox(width: 6),
                                Text(
                                  'Add Exercises',
                                  style: TextStyle(
                                    color: AppColors.neonCyan,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // --- Global cart list or empty state ---
                    allExercisesWithCategory.isEmpty
                        ? _buildEmptyExercisePlaceholder()
                        : Column(
                            children: [
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: allExercisesWithCategory.length,
                                separatorBuilder: (_, __) =>
                                    const SizedBox(height: 10),
                                itemBuilder: (context, index) {
                                  final entry =
                                      allExercisesWithCategory[index];
                                  return _buildExerciseTile(
                                    exerciseName: entry.name,
                                    category: entry.category,
                                    number: index + 1,
                                  );
                                },
                              ),
                            ],
                          ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: ElevatedButton(
                onPressed: allExercises.isEmpty
                    ? null
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ActiveWorkoutScreen(
                              focusGroup: widget.focusGroup,
                              exercises: allExercises,
                              sessionDurationMinutes: sessionDurationMinutes,
                            ),
                          ),
                        );
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: allExercises.isEmpty
                      ? AppColors.buttonDarkBg
                      : AppColors.neonCyan,
                  disabledForegroundColor: AppColors.textMuted,
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28)),
                ),
                child: Text(
                  allExercises.isEmpty
                      ? 'START'
                      : 'START · ${allExercises.length} EXERCISES  →',
                  style: TextStyle(
                    color: allExercises.isEmpty
                        ? AppColors.textMuted
                        : Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyExercisePlaceholder() {
    return GestureDetector(
      onTap: _openExerciseSelector,
      child: Container(
        width: double.infinity,
        height: 140,
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: AppColors.cardStroke,
              width: 1.5,
              style: BorderStyle.solid),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.fitness_center,
                color: AppColors.textSecondary, size: 28),
            SizedBox(height: 12),
            Text(
              'NO WORKOUTS INCLUDED YET',
              style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              'Tap here to add matching category sets',
              style: TextStyle(color: AppColors.textMuted, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExerciseTile({
    required String exerciseName,
    required String category,
    required int number,
  }) {
    final dotColor = _colorForCategory(category);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardStroke, width: 1.2),
      ),
      child: Row(
        children: [
          // Colored dot indicating which category this came from
          //const SizedBox(width: 14),
          Expanded(
            child: Text(
              exerciseName,
              style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
          ),
          // "#N" position label
          Text(
            '$number',
            style: const TextStyle(
              color: Color.fromARGB(0, 107, 122, 135),
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 12),
          // Remove button
          GestureDetector(
            onTap: () =>
                ref.read(cartProvider.notifier).removeExercise(exerciseName),

              child: const Icon(Icons.close, color: Color.fromARGB(255, 0, 229, 193), size: 17),
            ),
        ],
      ),
    );
  }
}