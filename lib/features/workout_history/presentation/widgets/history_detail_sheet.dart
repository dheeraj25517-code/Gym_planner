import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class HistoryDetailSheet extends StatelessWidget {
  final Map<String, dynamic> sessionData;

  const HistoryDetailSheet({super.key, required this.sessionData});

  @override
  Widget build(BuildContext context) {
    final List<dynamic> exercises = sessionData['exercises'];
    final int rating = sessionData['rating'];

    return Container(
      height: MediaQuery.of(context).size.height * 0.82,
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag handle marker element
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

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sessionData['date'],
                      style: const TextStyle(color: AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${sessionData['focusGroup']} BREAKDOWN',
                      style: const TextStyle(color: AppColors.textPrimary, fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: AppColors.textSecondary),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),
          ),
          const Divider(color: AppColors.cardStroke, thickness: 1),

          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Performance Stars Metrics View ---
                  const Text('PERFORMANCE RATING', style: TextStyle(color: AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        index < rating ? Icons.star : Icons.star_border,
                        color: index < rating ? AppColors.neonCyan : AppColors.textMuted,
                        size: 22,
                      );
                    }),
                  ),
                  const SizedBox(height: 20),

                  // --- Muscle Focus Box Display ---
                  const Text('PRIMARY MUSCLE FOCUS', style: TextStyle(color: AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Text(
                    sessionData['muscleNotes'].isEmpty ? 'None provided' : sessionData['muscleNotes'],
                    style: const TextStyle(color: AppColors.textPrimary, fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 24),

                  // --- Completed Movements Sets Log Loop List ---
                  const Text('LOGGED EXERCISES', style: TextStyle(color: AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: exercises.length,
                    itemBuilder: (context, exIdx) {
                      final exercise = exercises[exIdx];
                      final List<dynamic> sets = exercise['sets'];

                      return Container(
                        margin: const EdgeInsets.only(bottom: 14),
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: AppColors.cardBackground,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.cardStroke),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              exercise['name'],
                              style: const TextStyle(color: AppColors.neonCyan, fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 12),
                            // Sets Grid loop listing output fields
                            Column(
                              children: List.generate(sets.length, (setIdx) {
                                final currentSet = sets[setIdx];
                                final isDrop = currentSet['type'] == 'Drop';

                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Set ${setIdx + 1}',
                                        style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
                                      ),
                                      Text(
                                        '${currentSet['weight']} kg x ${currentSet['reps']} reps',
                                        style: const TextStyle(color: AppColors.textPrimary, fontSize: 13, fontWeight: FontWeight.w600),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                        decoration: BoxDecoration(
                                          color: isDrop ? AppColors.neonYellow.withOpacity(0.1) : AppColors.neonOrange.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(6),
                                          border: Border.all(color: isDrop ? AppColors.neonYellow : AppColors.neonOrange, width: 0.8),
                                        ),
                                        child: Text(
                                          currentSet['type'].toUpperCase(),
                                          style: TextStyle(color: isDrop ? AppColors.neonYellow : AppColors.neonOrange, fontSize: 9, fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  
                  // --- General Session Comments Block ---
                  if (sessionData['comments'].isNotEmpty) ...[
                    const SizedBox(height: 12),
                    const Text('ADDITIONAL COMMENTS', style: TextStyle(color: AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    Text(
                      sessionData['comments'],
                      style: const TextStyle(color: AppColors.textPrimary, fontSize: 13, height: 1.4),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}