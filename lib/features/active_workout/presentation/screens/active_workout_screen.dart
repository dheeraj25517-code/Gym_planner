import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../workout_review/presentation/screens/review_session_screen.dart';
import '../controllers/active_workout_controller.dart';
import '../controllers/timer_controller.dart';
import '../../domain/models/set_log.dart';
import 'package:gym_planner/timer_foreground.dart';

class ActiveWorkoutScreen extends ConsumerStatefulWidget {
  final String focusGroup;
  final List<String> exercises;
  final int sessionDurationMinutes;

  const ActiveWorkoutScreen({
    super.key,
    required this.focusGroup,
    required this.exercises,
    required this.sessionDurationMinutes,
  });

  @override
  ConsumerState<ActiveWorkoutScreen> createState() => _ActiveWorkoutScreenState();
}

class _ActiveWorkoutScreenState extends ConsumerState<ActiveWorkoutScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(activeWorkoutControllerProvider.notifier)
          .beginNewWorkoutSession(widget.focusGroup, widget.exercises);
      ref.read(timerProvider.notifier).startTimer(widget.sessionDurationMinutes);
      _startForegroundTask(widget.sessionDurationMinutes);
    });
  }

  // ─── Foreground service helpers ────────────────────────────────────────────

  Future<void> _startForegroundTask(int durationMinutes) async {
    // v8 API: startService uses callback: named param
    final result = await FlutterForegroundTask.startService(
      serviceId: 1001,
      notificationTitle: '${widget.focusGroup} Workout',
      notificationText: 'Timer running — tap to return',
      callback: startCallback,
    );
    if (result is ServiceRequestSuccess) {
      // Seed the service isolate with the initial seconds so it can
      // count down independently even when the app is backgrounded.
      FlutterForegroundTask.sendDataToTask(durationMinutes * 60);
    }
  }

  void _stopForegroundTask() {
    FlutterForegroundTask.stopService();
  }

  // ─── Confirmation dialogs ──────────────────────────────────────────────────

  /// "Are you sure you want to leave? Progress will be lost."
  Future<bool> _confirmLeave() async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.cardBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'LEAVE WORKOUT?',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
        content: const Text(
          'Your selected exercises and logged sets will be lost. Are you sure you want to leave?',
          style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('KEEP TRAINING',
                style: TextStyle(color: AppColors.neonCyan, fontWeight: FontWeight.bold)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('LEAVE',
                style: TextStyle(color: AppColors.neonOrange, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  /// "Are you sure you want to save this session?"
  Future<bool> _confirmSave() async {
    final workoutSession = ref.read(activeWorkoutControllerProvider);
    final totalSets = workoutSession?.exercisesLog.values
        .fold<int>(0, (sum, sets) => sum + sets.length) ?? 0;
    final exerciseCount = workoutSession?.exercisesLog.keys.length ?? 0;
    final secondsElapsed = ref.read(timerProvider);
    final minutesDone = ((widget.sessionDurationMinutes * 60 - secondsElapsed) / 60).floor();

    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.cardBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'SAVE SESSION?',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Confirm you want to log this workout:',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
            ),
            const SizedBox(height: 16),
            _summaryRow(Icons.fitness_center, '$exerciseCount exercises'),
            const SizedBox(height: 8),
            _summaryRow(Icons.layers, '$totalSets total sets'),
            const SizedBox(height: 8),
            _summaryRow(Icons.timer, '$minutesDone min completed'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('GO BACK',
                style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.bold)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('SAVE',
                style: TextStyle(color: AppColors.neonCyan, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  Widget _summaryRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: AppColors.neonCyan, size: 16),
        const SizedBox(width: 10),
        Text(text,
            style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 13,
                fontWeight: FontWeight.w600)),
      ],
    );
  }

  // ─── Timer display ─────────────────────────────────────────────────────────

  String _formatTimerText(int totalSeconds) {
    final int hours = totalSeconds ~/ 3600;
    final int minutes = (totalSeconds % 3600) ~/ 60;
    final int seconds = totalSeconds % 60;
    final String mStr = minutes.toString().padLeft(2, '0');
    final String sStr = seconds.toString().padLeft(2, '0');
    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:$mStr:$sStr';
    }
    return '$mStr:$sStr';
  }

  // ─── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final secondsRemaining = ref.watch(timerProvider);
    final workoutSession = ref.watch(activeWorkoutControllerProvider);

    // Keep foreground notification text in sync with countdown
    if (secondsRemaining > 0) {
      FlutterForegroundTask.updateService(
        notificationText: 'Time remaining: ${_formatTimerText(secondsRemaining)}',
      );
    }

    if (workoutSession == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(color: AppColors.neonCyan)),
      );
    }

    final exercisesLog = workoutSession.exercisesLog;

    // WillPopScope intercepts the Android back button/gesture
    return WillPopScope(
      onWillPop: () async {
        final leave = await _confirmLeave();
        if (leave) {
          ref.read(timerProvider.notifier).stopAndResetTimer();
          _stopForegroundTask();
        }
        return leave;
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              // ── Top banner ──────────────────────────────────────────────
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                decoration: const BoxDecoration(
                  color: AppColors.cardBackground,
                  border: Border(
                      bottom: BorderSide(color: AppColors.cardStroke, width: 1.5)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Back button — also guarded by confirm dialog
                    GestureDetector(
                      onTap: () async {
                        final leave = await _confirmLeave();
                        if (leave && mounted) {
                          ref.read(timerProvider.notifier).stopAndResetTimer();
                          _stopForegroundTask();
                          Navigator.pop(context);
                        }
                      },
                      child: const Icon(Icons.arrow_back_ios_new,
                          color: AppColors.textSecondary, size: 18),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'ACTIVE TRACKING',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${widget.focusGroup.toUpperCase()} SPREAD',
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    // Countdown clock
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 10),
                      decoration: BoxDecoration(
                        color: secondsRemaining <= 60
                            ? AppColors.neonOrange.withOpacity(0.15)
                            : AppColors.buttonDarkBg,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: secondsRemaining <= 60
                              ? AppColors.neonOrange
                              : AppColors.cardStroke,
                        ),
                      ),
                      child: Text(
                        _formatTimerText(secondsRemaining),
                        style: TextStyle(
                          color: secondsRemaining <= 60
                              ? AppColors.neonOrange
                              : AppColors.neonCyan,
                          fontSize: 20,
                          fontFamily: 'Courier',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Exercise list ───────────────────────────────────────────
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(24),
                  itemCount: exercisesLog.keys.length,
                  itemBuilder: (context, index) {
                    final exerciseName = exercisesLog.keys.elementAt(index);
                    final setsList = exercisesLog[exerciseName]!;
                    return _buildExerciseTrackingBlock(exerciseName, setsList);
                  },
                ),
              ),

              // ── Finish button ───────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: ElevatedButton(
                  onPressed: () async {
                    final confirmed = await _confirmSave();
                    if (!confirmed || !mounted) return;

                    ref.read(activeWorkoutControllerProvider.notifier)
                        .finalizeSession();
                    ref.read(timerProvider.notifier).pauseTimer();
                    _stopForegroundTask();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ReviewSessionScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 229, 193),
                    minimumSize: const Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28)),
                  ),
                  child: const Text(
                    'FINISH AND LOG SESSION',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        letterSpacing: 1.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─── Exercise block (unchanged from your existing code) ───────────────────

  static const int _kSetFlex = 1;
  static const int _kWeightFlex = 2;
  static const int _kRepsFlex = 2;
  static const int _kStyleFlex = 2;
  static const double _kGapAfterSet = 15;
  static const double _kGapAfterWeight = 8;
  static const double _kGapAfterReps = 8;

  Widget _buildExerciseTrackingBlock(String title, List<SetLog> setsList) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.cardStroke, width: 1.2),
      ),
      child: ExpansionTile(
        initiallyExpanded: true,
        shape: const Border(),
        collapsedShape: const Border(),
        iconColor: AppColors.neonCyan,
        textColor: AppColors.neonCyan,
        title: Text(title,
            style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
            child: Column(
              children: [
                const Divider(color: AppColors.cardStroke),
                const SizedBox(height: 8),
                const Row(
                  children: [
                    Expanded(flex: _kSetFlex, child: Text('SET', style: TextStyle(color: AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.bold))),
                    SizedBox(width: _kGapAfterSet),
                    Expanded(flex: _kWeightFlex, child: Text('WEIGHT (KG)', style: TextStyle(color: AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.bold))),
                    SizedBox(width: _kGapAfterWeight),
                    Expanded(flex: _kRepsFlex, child: Text('REPS', style: TextStyle(color: AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.bold))),
                    SizedBox(width: _kGapAfterReps),
                    Expanded(flex: _kStyleFlex, child: Text('TYPE', style: TextStyle(color: AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.bold))),
                    SizedBox(width: 18),
                  ],
                ),
                const SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: setsList.length,
                  itemBuilder: (context, idx) {
                    final currentSet = setsList[idx];
                    return _SetRow(
                      key: ValueKey('$title-set-${currentSet.setNumber}'),
                      currentSet: currentSet,
                      title: title,
                      idx: idx,
                      canDelete: setsList.length > 1,
                      onWeightChanged: (v) => ref
                          .read(activeWorkoutControllerProvider.notifier)
                          .updateInlineSetMetrics(title, idx, weight: v),
                      onRepsChanged: (v) => ref
                          .read(activeWorkoutControllerProvider.notifier)
                          .updateInlineSetMetrics(title, idx, reps: v),
                      onTypeChanged: (v) => ref
                          .read(activeWorkoutControllerProvider.notifier)
                          .updateInlineSetMetrics(title, idx, type: v),
                      onDelete: () => ref
                          .read(activeWorkoutControllerProvider.notifier)
                          .removeSetFromExercise(title, idx),
                      buildInlineInputDecoration: _buildInlineInputDecoration,
                    );
                  },
                ),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: () => ref
                      .read(activeWorkoutControllerProvider.notifier)
                      .addSetToExercise(title),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add, color: AppColors.neonCyan, size: 16),
                        SizedBox(width: 6),
                        Text('ADD ADDITIONAL SET',
                            style: TextStyle(
                                color: AppColors.neonCyan,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildStyleDropdown(
      SetLog currentSet, ValueChanged<String> onTypeChanged) {
    final bool isDropSet = currentSet.type == 'DROP';
    final String currentValue = isDropSet ? 'D' : 'E';
    return Container(
      height: 34,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.neonOrange.withOpacity(0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.neonOrange, width: 1.2),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: currentValue,
          isDense: true,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down,
              color: AppColors.neonOrange, size: 16),
          dropdownColor: AppColors.buttonDarkBg,
          borderRadius: BorderRadius.circular(8),
          style: const TextStyle(
              color: AppColors.neonOrange,
              fontSize: 12,
              fontWeight: FontWeight.bold),
          alignment: Alignment.center,
          items: const [
            DropdownMenuItem(
                value: 'E',
                child: Text('E', textAlign: TextAlign.center)),
            DropdownMenuItem(
                value: 'D',
                child: Text('D', textAlign: TextAlign.center)),
          ],
          onChanged: (value) {
            if (value == null) return;
            onTypeChanged(value == 'D' ? 'DROP' : 'EXACT');
          },
        ),
      ),
    );
  }

  static InputDecoration _buildInlineInputDecoration(String initialValue) {
    return InputDecoration(
      hintText: initialValue,
      hintStyle:
          const TextStyle(color: AppColors.textSecondary, fontSize: 14),
      contentPadding: EdgeInsets.zero,
      filled: true,
      fillColor: AppColors.buttonDarkBg,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide:
            const BorderSide(color: AppColors.cardStroke, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide:
            const BorderSide(color: AppColors.neonCyan, width: 1.2),
      ),
    );
  }
}

// ─── _SetRow (stateful, owns TextEditingControllers + FocusNodes) ─────────────

class _SetRow extends StatefulWidget {
  final SetLog currentSet;
  final String title;
  final int idx;
  final bool canDelete;
  final ValueChanged<double> onWeightChanged;
  final ValueChanged<int> onRepsChanged;
  final ValueChanged<String> onTypeChanged;
  final VoidCallback onDelete;
  final InputDecoration Function(String) buildInlineInputDecoration;

  const _SetRow({
    super.key,
    required this.currentSet,
    required this.title,
    required this.idx,
    required this.canDelete,
    required this.onWeightChanged,
    required this.onRepsChanged,
    required this.onTypeChanged,
    required this.onDelete,
    required this.buildInlineInputDecoration,
  });

  @override
  State<_SetRow> createState() => _SetRowState();
}

class _SetRowState extends State<_SetRow> {
  late final TextEditingController _weightController;
  late final TextEditingController _repsController;
  late final FocusNode _weightFocusNode;
  late final FocusNode _repsFocusNode;

  @override
  void initState() {
    super.initState();
    _weightController = TextEditingController(
        text: widget.currentSet.weight.toStringAsFixed(0));
    _repsController =
        TextEditingController(text: widget.currentSet.reps.toString());
    _weightFocusNode = FocusNode();
    _repsFocusNode = FocusNode();
  }

  @override
  void didUpdateWidget(covariant _SetRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_weightFocusNode.hasFocus) {
      final newText = widget.currentSet.weight.toStringAsFixed(0);
      if (_weightController.text != newText) _weightController.text = newText;
    }
    if (!_repsFocusNode.hasFocus) {
      final newText = widget.currentSet.reps.toString();
      if (_repsController.text != newText) _repsController.text = newText;
    }
  }

  @override
  void dispose() {
    _weightController.dispose();
    _repsController.dispose();
    _weightFocusNode.dispose();
    _repsFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      child: Row(
        children: [
          Expanded(
            flex: _ActiveWorkoutScreenState._kSetFlex,
            child: Text('${widget.currentSet.setNumber}',
                style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: _ActiveWorkoutScreenState._kGapAfterSet),
          Expanded(
            flex: _ActiveWorkoutScreenState._kWeightFlex,
            child: SizedBox(
              height: 30,
              child: TextField(
                controller: _weightController,
                focusNode: _weightFocusNode,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: AppColors.textPrimary, fontSize: 14),
                decoration: widget.buildInlineInputDecoration(
                    widget.currentSet.weight.toStringAsFixed(0)),
                onChanged: (val) {
                  final v = double.tryParse(val);
                  if (v != null) widget.onWeightChanged(v);
                },
              ),
            ),
          ),
          const SizedBox(width: _ActiveWorkoutScreenState._kGapAfterWeight),
          Expanded(
            flex: _ActiveWorkoutScreenState._kRepsFlex,
            child: SizedBox(
              height: 30,
              child: TextField(
                controller: _repsController,
                focusNode: _repsFocusNode,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: AppColors.textPrimary, fontSize: 14),
                decoration: widget.buildInlineInputDecoration(
                    widget.currentSet.reps.toString()),
                onChanged: (val) {
                  final v = int.tryParse(val);
                  if (v != null) widget.onRepsChanged(v);
                },
              ),
            ),
          ),
          const SizedBox(width: _ActiveWorkoutScreenState._kGapAfterReps),
          Expanded(
            flex: _ActiveWorkoutScreenState._kStyleFlex,
            child: _ActiveWorkoutScreenState._buildStyleDropdown(
                widget.currentSet, widget.onTypeChanged),
          ),
          IconButton(
            constraints: const BoxConstraints(),
            padding: EdgeInsets.zero,
            icon: Icon(Icons.delete,
                color: widget.canDelete
                    ? const Color.fromARGB(255, 0, 229, 193)
                    : Colors.transparent,
                size: 18),
            onPressed: widget.onDelete,
          ),
        ],
      ),
    );
  }
}