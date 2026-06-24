import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../features/home/presentation/screens/home_screen.dart';
import '../../../active_workout/presentation/controllers/active_workout_controller.dart';
import '../../../workout_history/presentation/controllers/history_controller.dart';

class ReviewSessionScreen extends ConsumerStatefulWidget {
  const ReviewSessionScreen({super.key});

  @override
  ConsumerState<ReviewSessionScreen> createState() => _ReviewSessionScreenState();
}

class _ReviewSessionScreenState extends ConsumerState<ReviewSessionScreen> {
  int _selectedRating = 0;
  final TextEditingController _focusController = TextEditingController();
  final TextEditingController _commentsController = TextEditingController();

  @override
  void dispose() {
    _focusController.dispose();
    _commentsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false, // Prevents accidently going back into active tracker
        actions: [
          TextButton(
            onPressed: () {
              // Reset back to home screen cleanly without keeping the stack
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
                (route) => false,
              );
            },
            child: const Text(
              'SKIP',
              style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(), // Dismiss keyboard on background tap
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
                        'SESSION COMPLETE',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'REVIEW LOG',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 28,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(height: 36),

                      // --- Star Rating Module ---
                      const Text(
                        'HOW WAS YOUR PERFORMANCE?',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List.generate(5, (index) {
                          final starNumber = index + 1;
                          final isSelected = starNumber <= _selectedRating;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedRating = starNumber;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 12.0),
                              child: Icon(
                                isSelected ? Icons.star : Icons.star_border,
                                color: isSelected ? AppColors.neonCyan : AppColors.textMuted,
                                size: 36,
                              ),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 36),

                      // --- Muscle Focus Input ---
                      const Text(
                        'PRIMARY MUSCLE FOCUS NOTES',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _focusController,
                        style: const TextStyle(color: AppColors.textPrimary, fontSize: 15),
                        decoration: _buildInputDecoration('e.g., Upper Abs emphasis, Lower Bicep peak'),
                      ),
                      const SizedBox(height: 36),

                      // --- Comments Input Box ---
                      const Text(
                        'ADDITIONAL COMMENTS',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _commentsController,
                        maxLines: 4,
                        style: const TextStyle(color: AppColors.textPrimary, fontSize: 15),
                        decoration: _buildInputDecoration('How did it feel? Energy levels, recovery times, etc...'),
                      ),
                    ],
                  ),
                ),
              ),

              // --- Sticky Footer Submit Button ---
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: ElevatedButton(
                  onPressed: () async {
                    final session = ref.read(activeWorkoutControllerProvider);
                    if (session == null || session.endTime == null) {
                      return;
                    }

                    await ref.read(historyControllerProvider.notifier).saveWorkoutSessionRecord(
                          session: session,
                          performanceRating: _selectedRating,
                          muscleNotes: _focusController.text.trim(),
                          generalComments: _commentsController.text.trim(),
                        );

                    ref.read(activeWorkoutControllerProvider.notifier).clearActiveSession();

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                      (route) => false,
                    );
                  },
                  child: const Text('SAVE WORKOUT RECORD'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: AppColors.textMuted, fontSize: 14),
      contentPadding: const EdgeInsets.all(18),
      filled: true,
      fillColor: AppColors.cardBackground,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.cardStroke, width: 1.2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.neonCyan, width: 1.5),
      ),
    );
  }
}