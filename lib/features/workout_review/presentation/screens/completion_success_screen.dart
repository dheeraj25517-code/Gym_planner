import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../active_workout/presentation/controllers/active_workout_controller.dart';
import '../../../active_workout/presentation/controllers/timer_controller.dart';

class CompletionSuccessScreen extends ConsumerWidget {
  final double totalVolume;
  final int durationMinutes;

  const CompletionSuccessScreen({
    super.key,
    required this.totalVolume,
    required this.durationMinutes,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),

              // --- Animated Graphic Checkmark Indicator ---
              Center(
                child: Container(
                  height: 96,
                  width: 96,
                  decoration: BoxDecoration(
                    color: AppColors.neonCyan.withOpacity(0.12),
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.neonCyan, width: 2),
                  ),
                  child: const Icon(
                    Icons.check_circle_outline_rounded,
                    color: AppColors.neonCyan,
                    size: 48,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              const Text(
                'WORKOUT COMMITTED',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Your progress and lifting logs have been permanently written to your local ledger history.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
              
              const SizedBox(height: 48),

              // --- Metrics Highlights Grid Dashboard Row ---
              Row(
                children: [
                  Expanded(
                    child: _buildMetricCard(
                      label: 'TOTAL DURATION',
                      value: '$durationMinutes',
                      unit: 'MIN',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildMetricCard(
                      label: 'VOLUME MOVED',
                      value: totalVolume.toStringAsFixed(0),
                      unit: 'KG',
                    ),
                  ),
                ],
              ),

              const Spacer(),

              // --- Dismiss Action Button Button ---
              ElevatedButton(
                onPressed: () {
                  // Completely clear active live workout memory tracking frames out of Riverpod
                  ref.read(activeWorkoutControllerProvider.notifier).clearActiveSession();
                  ref.read(timerProvider.notifier).stopAndResetTimer();

                  // Pop all nested setup sheets out of stack view to jump straight back to dashboard
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonDarkBg,
                  side: const BorderSide(color: AppColors.cardStroke, width: 1.2),
                ),
                child: const Text(
                  'BACK TO HOME DASHBOARD',
                  style: TextStyle(
                    color: AppColors.neonCyan,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricCard({required String label, required String value, required String unit}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardStroke, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: AppColors.neonCyan,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Courier',
                ),
              ),
              const SizedBox(width: 4),
              Text(
                unit,
                style: const TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}