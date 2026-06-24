import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/database/isar_service.dart';
import 'core/database/data_seeder.dart';
import 'features/home/presentation/screens/home_screen.dart';
import 'package:gym_planner/foreground_task_init.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterForegroundTask.initCommunicationPort();

  await IsarService.instance.init();
  await DataSeeder.seedDatabaseIfEmpty();
  initForegroundTask();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gym Planner',
      theme: ThemeData.dark(), // Or whatever your theme setup looks like
      home: const HomeScreen(), // Or your primary landing screen
    );
  }
}