import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/models/workout_record.dart';
import 'history_detail_sheet.dart';
import 'dart:convert';


class HistoryItemsCard extends StatelessWidget {
  final WorkoutRecord record;

  const HistoryItemsCard({super.key, required this.record});

  String _formatDateString(DateTime dt) {
    final List<String> months = ['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'];
    return '${dt.day} ${months[dt.month - 1]}, ${dt.year}';
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => HistoryDetailSheet(
            sessionData: {
              'date': _formatDateString(record.timestamp),
              'focusGroup': record.focusGroup,
              'exercises': record.loggedExercisesJson.map((s) => jsonDecode(s)).toList(),
              'rating': record.performanceRating,
              'muscleNotes': record.muscleNotes,
              'comments': record.generalComments,
            },
          ),
        );
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.cardStroke, width: 1.2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _formatDateString(record.timestamp),
                  style: const TextStyle(color: AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Text(
                  '${record.focusGroup} SESSION',
                  style: const TextStyle(color: AppColors.neonCyan, fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.timer_outlined, color: AppColors.textMuted, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      '${record.durationMinutes} MIN',
                      style: const TextStyle(color: AppColors.textMuted, fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  ],
                )
              ],
            ),
            const Icon(Icons.arrow_forward_ios, color: AppColors.textMuted, size: 16),
          ],
        ),
      ),
    );
  }
}