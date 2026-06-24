import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../workout_setup/presentation/screens/training_day_screen.dart';
import '../../../workout_history/presentation/screens/history_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Subtitle Tagline Text
              const Text(
                'A SESSION AWAITS',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 8),
              // Main Header Stack text
              const Text(
                'GYM',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.2,
                ),
              ),
              const Text(
                'PLANNER',
                style: TextStyle(
                  color: AppColors.neonCyan,
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 48),

              // Summary Status Overview Card
              Container(
                width: double.infinity,
                height: 240,
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: AppColors.cardStroke, width: 1.5),
                ),
                child: Stack(
                  children: [
                    // Faded Structural Geometric background overlay details
                    Positioned(
                      right: -30,
                      bottom: -30,
                      child: Opacity(
                        opacity: 0.04,
                        child: Container(
                          width: 260,
                          height: 260,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      bottom: -60,
                      child: Opacity(
                        opacity: 0.04,
                        child: Container(
                          width: 220,
                          height: 220,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        ),
                      ),
                    ),
                    
                    // Large center stylized background watermark watermark text
                    Center(
                      child: Text(
                        'GYM',
                        style: TextStyle(
                          fontSize: 90,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withOpacity(0.025),
                          letterSpacing: 4,
                        ),
                      ),
                    ),

                    // Inside Metrics Rows Elements
                    Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              _buildMetricItem('6', 'DAYS'),
                              _buildMetricItem('6', 'MUSCLE\nGROUPS'),
                              _buildMetricItem('FIT', 'YOUR\nGOAL', isHighlight: true),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              const Spacer(),

              // Primary Action: START WORKOUT
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TrainingDayScreen()),
                  );
                },
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 0, 229, 193),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.cardStroke, width: 1.2),
                  ),
                  child: const Center(
                    child: Text(
                      'START WORKOUT',
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            
              // Secondary Action Button Frame: HISTORY
              // Inside home_screen.dart:
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HistoryScreen()),
                  );
                },
              // ... rest of the widget code remains identical
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.buttonDarkBg,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.cardStroke, width: 1.2),
                  ),
                  child: const Center(
                    child: Text(
                      'HISTORY',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricItem(String value, String label, {bool isHighlight = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: TextStyle(
            color: isHighlight ? AppColors.neonCyan : AppColors.neonCyan,
            fontSize: 28,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
            height: 1.2,
          ),
        ),
      ],
    );
  }
}