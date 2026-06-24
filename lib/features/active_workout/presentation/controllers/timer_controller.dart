import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// State now holds seconds REMAINING (counts down to 0).
// UI reads this exactly as before via ref.watch(timerProvider).
class TimerController extends StateNotifier<int> {
  TimerController() : super(0);

  Timer? _tickerTimer;
  final AudioPlayer _audioPlayer = AudioPlayer();
  int _totalSeconds = 0; // remembers the original duration for reset

  /// Starts a countdown from [durationMinutes].
  /// Call this instead of the old no-arg startTimer() —
  /// pass sessionDurationMinutes directly from your screen.
  void startTimer(int durationMinutes) {
    _tickerTimer?.cancel();
    _totalSeconds = durationMinutes * 60;
    state = _totalSeconds;

    _tickerTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state <= 1) {
        // Hit zero — stop ticking and ring
        state = 0;
        timer.cancel();
        _ring();
      } else {
        state--;
      }
    });
  }

  /// Plays the completion sound from assets/audio/
  Future<void> _ring() async {
    await _audioPlayer.play(AssetSource('audio/timer_done.mp3'));
  }

  /// Stops the ring manually (e.g. user taps dismiss)
  Future<void> stopRing() async {
    await _audioPlayer.stop();
  }

  /// Temporarily halts the countdown ticker
  void pauseTimer() {
    _tickerTimer?.cancel();
  }

  /// Resumes ticking from the exactly saved remaining seconds
  void resumeTimer() {
    _tickerTimer?.cancel();
    if (state <= 0) return; // nothing to resume
    _tickerTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state <= 1) {
        state = 0;
        timer.cancel();
        _ring();
      } else {
        state--;
      }
    });
  }

  /// Destroys and cleans up internal timer + audio
  void stopAndResetTimer() {
    _tickerTimer?.cancel();
    _audioPlayer.stop();
    state = 0;
  }

  @override
  void dispose() {
    _tickerTimer?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }
}

final timerProvider = StateNotifierProvider<TimerController, int>((ref) {
  return TimerController();
});