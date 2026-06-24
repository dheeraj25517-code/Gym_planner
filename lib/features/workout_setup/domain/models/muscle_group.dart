import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

enum MuscleGroup {
  chest(title: 'CHEST', subtitle: 'PECTORALS', color: AppColors.neonCyan),
  triceps(title: 'TRICEPS', subtitle: 'POSTERIOR ARMS', color: AppColors.neonCyan),
  back(title: 'BACK', subtitle: 'LATS, RHOMBOIDS & TRAPS', color: AppColors.neonCyan),
  biceps(title: 'BICEPS', subtitle: 'ANTERIOR ARMS', color: AppColors.neonCyan),
  forearms(title: 'FOREARMS', subtitle: 'WRIST FLEXORS & EXTENSORS', color: AppColors.neonCyan);

  final String title;
  final String subtitle;
  final Color color;

  const MuscleGroup({
    required this.title,
    required this.subtitle,
    required this.color,
  });

  /// Safely resolves raw string matches (e.g., from DB) into typed Enums
  static MuscleGroup fromString(String label) {
    return MuscleGroup.values.firstWhere(
      (e) => e.title == label.toUpperCase(),
      orElse: () => MuscleGroup.chest,
    );
  }
}