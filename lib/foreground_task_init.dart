import 'package:flutter_foreground_task/flutter_foreground_task.dart';

/// Call initForegroundTask() from main() before runApp(),
/// and initCommunicationPort() also in main() before runApp().
void initForegroundTask() {
  FlutterForegroundTask.init(
    androidNotificationOptions: AndroidNotificationOptions(
      channelId: 'gym_planner_timer',
      channelName: 'Workout Timer',
      channelDescription: 'Shows your live workout countdown timer',
      onlyAlertOnce: true, // no sound/vibration on each update
      channelImportance: NotificationChannelImportance.LOW,
      priority: NotificationPriority.LOW,
    ),
    iosNotificationOptions: const IOSNotificationOptions(
      showNotification: false,
      playSound: false,
    ),
    foregroundTaskOptions: ForegroundTaskOptions(
      // fires onRepeatEvent every 1 second so notification stays in sync
      eventAction: ForegroundTaskEventAction.repeat(1000),
      autoRunOnBoot: false,
      allowWakeLock: true, // keeps CPU alive so timer stays accurate
      allowWifiLock: false,
    ),
  );
}