import 'package:flutter_foreground_task/flutter_foreground_task.dart';

// Top-level callback — must be top-level (not inside a class) and
// annotated with @pragma so the Dart compiler keeps it in release builds.
@pragma('vm:entry-point')
void startCallback() {
  FlutterForegroundTask.setTaskHandler(TimerTaskHandler());
}

class TimerTaskHandler extends TaskHandler {
  // Tracks remaining seconds internally inside the service isolate.
  // The main isolate sends the current count via sendDataToTask().
  int _remainingSeconds = 0;

  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {
    // Nothing to init — remaining seconds arrive via onReceiveData()
  }

  // Fires every 1000ms as set in ForegroundTaskEventAction.repeat(1000).
  // Ticks down and updates the notification text each second.
  @override
  void onRepeatEvent(DateTime timestamp) {
    if (_remainingSeconds > 0) {
      _remainingSeconds--;

      final int m = _remainingSeconds ~/ 60;
      final int s = _remainingSeconds % 60;
      final String timeText =
          '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';

      FlutterForegroundTask.updateService(
        notificationTitle: 'Workout in progress',
        notificationText: 'Time remaining: $timeText',
      );

      // Send current seconds back to main isolate so Riverpod
      // timerProvider stays in sync even while app is backgrounded.
      FlutterForegroundTask.sendDataToMain(_remainingSeconds);
    } else {
      // Timer hit zero — notify main isolate
      FlutterForegroundTask.updateService(
        notificationTitle: 'Workout complete!',
        notificationText: "Time's up — tap to review your session",
      );
      FlutterForegroundTask.sendDataToMain(-1); // -1 = done signal
    }
  }

  @override
  Future<void> onDestroy(DateTime timestamp, bool isTimeout) async {
    // Nothing to clean up
  }

  // Called when main isolate sends data via FlutterForegroundTask.sendDataToTask().
  // We use this to seed the initial remaining seconds when the workout starts.
  @override
  void onReceiveData(Object data) {
    if (data is int && data >= 0) {
      _remainingSeconds = data;
    }
  }
}