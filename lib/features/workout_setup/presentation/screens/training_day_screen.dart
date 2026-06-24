import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import 'package:gym_planner/features/workout_setup/provider/cart_provider.dart';
import 'session_builder_screen.dart';

// Converted to ConsumerStatefulWidget so we can:
// 1. Use WillPopScope to intercept the Android back gesture
// 2. Read cartProvider to clear it when the user confirms leaving
class TrainingDayScreen extends ConsumerStatefulWidget {
  const TrainingDayScreen({super.key});

  @override
  ConsumerState<TrainingDayScreen> createState() => _TrainingDayScreenState();
}

class _TrainingDayScreenState extends ConsumerState<TrainingDayScreen> {
  static const List<Map<String, dynamic>> targetDays = [
    {'title': 'CORE',      'subtitle': 'ABS & OBLIQUES',              'color': AppColors.neonCyan},
    {'title': 'TRICEPS',   'subtitle': 'POSTERIOR ARMS',              'color': AppColors.neonCyan},
    {'title': 'CHEST',     'subtitle': 'PECTORALS',                   'color': AppColors.neonCyan},
    {'title': 'BACK',      'subtitle': 'LATS, TRAPS & RHOMBOIDS',     'color': AppColors.neonCyan},
    {'title': 'LEGS',      'subtitle': 'QUADS & HAMSTRINGS',          'color': AppColors.neonCyan},
    {'title': 'SHOULDERS', 'subtitle': 'DELTOIDS',                    'color': AppColors.neonCyan},
    {'title': 'BICEPS',    'subtitle': 'ANTERIOR ARMS',               'color': AppColors.neonCyan},
    {'title': 'FOREARMS',  'subtitle': 'WRIST FLEXORS & EXTENSORS',   'color': AppColors.neonCyan},
  ];

  // Shows the leave confirmation dialog.
  // Returns true if the user confirmed they want to leave.
  Future<bool> _confirmLeave() async {
    final cartMap = ref.read(cartProvider);
    final hasItems = cartMap.isNotEmpty;

    // If the cart is empty there's nothing to warn about — just pop.
    if (!hasItems) return true;

    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.cardBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'EXIT TRAINING DAY?',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
        content: const Text(
          'Are you sure you want to exit? Your selected exercises will be lost.',
          style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text(
              'STAY',
              style: TextStyle(
                  color: AppColors.neonCyan, fontWeight: FontWeight.bold),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text(
              'EXIT',
              style: TextStyle(
                  color: AppColors.neonOrange, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  // Runs the confirm flow, clears the cart if confirmed, then pops.
  Future<void> _handleBackPress() async {
    final shouldLeave = await _confirmLeave();
    if (shouldLeave && mounted) {
      ref.read(cartProvider.notifier).clearCart();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    // WillPopScope catches the Android hardware/gesture back action.
    // The AppBar back button calls _handleBackPress() directly.
    return WillPopScope(
      onWillPop: () async {
        await _handleBackPress();
        // Always return false — we handle the pop manually inside
        // _handleBackPress() so we control exactly when it happens.
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new,
                color: AppColors.textPrimary, size: 20),
            onPressed: _handleBackPress,
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'CHOOSE YOUR FOCUS',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'TRAINING DAY',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: 32),

                Expanded(
                  child: GridView.builder(
                    itemCount: targetDays.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.1,
                    ),
                    itemBuilder: (context, index) {
                      final target = targetDays[index];
                      return _buildTrainingDayCard(context, target);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTrainingDayCard(
      BuildContext context, Map<String, dynamic> target) {
    final String title = target['title'];
    final String subtitle = target['subtitle'];
    final Color accentColor = target['color'];

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SessionBuilderScreen(focusGroup: title),
          ),
        );
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.cardStroke, width: 1.5),
        ),
        child: Stack(
          children: [
            // Background watermark letter
            Positioned(
              right: -10,
              bottom: -15,
              child: Opacity(
                opacity: 0.015,
                child: Text(
                  title[0],
                  style: const TextStyle(
                    fontSize: 90,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            // Title + subtitle
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: accentColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}