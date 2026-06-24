import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/database/isar_service.dart';
import '../../domain/models/exercise.dart';
import 'package:isar/isar.dart';

class ExerciseSelectionSheet extends StatefulWidget {
  final String focusGroup; // e.g. "BICEPS", "CHEST" — matches muscleGroup field
  final List<String> currentSelection;
  final Function(List<String>) onExercisesSelected;

  const ExerciseSelectionSheet({
    super.key,
    required this.focusGroup,
    required this.currentSelection,
    required this.onExercisesSelected,
  });

  @override
  State<ExerciseSelectionSheet> createState() => _ExerciseSelectionSheetState();
}

class _ExerciseSelectionSheetState extends State<ExerciseSelectionSheet> {
  List<Exercise> _allAvailableExercises = [];
  List<String> _subMusclesFilters = [];
  String? _selectedSubMuscle;

  late List<String> _tempSelectedExerciseNames;

  @override
  void initState() {
    super.initState();
    _tempSelectedExerciseNames = List<String>.from(widget.currentSelection);
    _loadExercisesFromDatabase();
  }

  Future<void> _loadExercisesFromDatabase() async {
    final isar = IsarService.instance.db;

    // Filter by muscleGroup so only exercises belonging to this category load.
    // e.g. focusGroup = "CHEST" → only Upper Chest / Lower Chest / Middle Chest
    // exercises appear; nothing from BACK, TRICEPS, etc. leaks in.
    final exercises = await isar.exercises
        .filter()
        .muscleGroupEqualTo(widget.focusGroup, caseSensitive: false)
        .findAll();

    // Sub-muscle pills are derived from primaryMuscle of the filtered set,
    // so they only ever show sub-muscles that belong to this focusGroup.
    final subMuscles = exercises
        .map((e) => e.primaryMuscle)
        .toSet()
        .toList()
      ..sort(); // alphabetical for consistency

    setState(() {
      _allAvailableExercises = exercises;
      _subMusclesFilters = subMuscles;
      // Pre-select the first pill so the list isn't blank on open
      _selectedSubMuscle = subMuscles.isNotEmpty ? subMuscles.first : null;
    });
  }

  List<Exercise> _getFilteredDisplayList() {
    if (_selectedSubMuscle == null) return _allAvailableExercises;
    return _allAvailableExercises
        .where((e) => e.primaryMuscle == _selectedSubMuscle)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final displayList = _getFilteredDisplayList();

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag handle
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              width: 48,
              height: 5,
              decoration: BoxDecoration(
                color: AppColors.cardStroke,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.focusGroup} – EXERCISES',
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '${_tempSelectedExerciseNames.length} in cart',
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppColors.buttonDarkBg,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.cardStroke, width: 1),
                    ),
                    child: const Icon(Icons.close,
                        color: AppColors.textSecondary, size: 16),
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: AppColors.cardStroke, thickness: 1),

          // Sub-muscle pill filter row — only shows sub-muscles of this focusGroup
          if (_subMusclesFilters.isNotEmpty) ...[
            Container(
              height: 48,
              padding: const EdgeInsets.only(left: 24.0),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: _subMusclesFilters.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, idx) {
                  final subMuscle = _subMusclesFilters[idx];
                  final isSelected = _selectedSubMuscle == subMuscle;
                  return ChoiceChip(
                    label: Text(subMuscle),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedSubMuscle = selected ? subMuscle : null;
                      });
                    },
                    selectedColor: AppColors.selectionActive,
                    backgroundColor: AppColors.cardBackground,
                    labelStyle: TextStyle(
                      color: isSelected
                          ? AppColors.neonCyan
                          : AppColors.textSecondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: isSelected
                            ? AppColors.neonCyan
                            : AppColors.cardStroke,
                        width: 1.2,
                      ),
                    ),
                    showCheckmark: false,
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
          ],

          // Exercise list — scoped to focusGroup + selected sub-muscle
          Expanded(
            child: displayList.isEmpty
                ? Center(
                    child: Text(
                      _allAvailableExercises.isEmpty
                          ? 'No ${widget.focusGroup} exercises found.'
                          : 'No exercises for this sub-muscle.',
                      style: const TextStyle(color: AppColors.textSecondary),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemCount: displayList.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, idx) {
                      final item = displayList[idx];
                      final name = item.name;
                      final isChecked =
                          _tempSelectedExerciseNames.contains(name);

                      return InkWell(
                        onTap: () {
                          setState(() {
                            if (isChecked) {
                              _tempSelectedExerciseNames.remove(name);
                            } else {
                              _tempSelectedExerciseNames.add(name);
                            }
                          });
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: isChecked
                                ? AppColors.selectionActive
                                : AppColors.cardBackground,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isChecked
                                  ? AppColors.neonCyan
                                  : AppColors.cardStroke,
                              width: 1.2,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      name,
                                      style: TextStyle(
                                        color: isChecked
                                            ? AppColors.neonCyan
                                            : AppColors.textPrimary,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    // Shows the sub-muscle (primaryMuscle) as subtitle
                                    Text(
                                      item.primaryMuscle,
                                      style: const TextStyle(
                                        color: AppColors.textSecondary,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                isChecked
                                    ? Icons.check_circle
                                    : Icons.radio_button_off,
                                color: isChecked
                                    ? AppColors.neonCyan
                                    : AppColors.textMuted,
                                size: 22,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),

          // CTA — "DONE · N EXERCISES" matching the reference image style
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: ElevatedButton(
              onPressed: () {
                // Always allow closing — if nothing selected, just dismisses.
                // If items are selected, commits them to the cart.
                widget.onExercisesSelected(_tempSelectedExerciseNames);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.neonCyan,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28)),
              ),
              child: Text(
                'DONE · ${_tempSelectedExerciseNames.length} EXERCISES',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}