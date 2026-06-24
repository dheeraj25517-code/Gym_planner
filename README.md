# Gym Planner 

A minimal, lightning-fast workout tracking application built with Flutter. Optimized with a dark theme aesthetic, this app helps you plan your gym sessions, track your historical sets, and manage your rest intervals without distractions.


---


## Features

* Ongoing Taskbar Timer: A background-rest monitoring engine that stays pinned to your phone's top taskbar/notification shade with a live countdown—even when your screen is locked.
* Audio Alerts: Built-in audio cues that ring out as soon as your rest period concludes, keeping you on schedule for your next set.
* Local History Backup & Restore: Securely export your entire workout history database into a single file to local storage or cloud directories. Easily restore your data at any time.
* Aesthetic Dark Theme: Built from the ground up utilizing an eye-straining-free `#000000` pitch-black dark interface layout.
* To add additional workouts use dataseeder.dart, in the format muscle_group|muscle|workout.

---

## Installation (How to use it)

You do not need to download Android Studio or compile code to use this app. Follow these simple steps:

1. Head over to the **[Releases](https://github.com/YOUR_USERNAME/gym_planner/releases)** section on the right side of this repository page.
2. Download the latest digitally signed installation package: **`app-release.apk`**.
3. Open the downloaded file on your Android device.
4. If prompted by Android, allow **"Install from Unknown Sources"** or click **"Install Anyway"** (this occurs because the app is independently signed and hosted on GitHub rather than the Google Play Store).
5. Open Gym Planner and start lifting!
NOTE THAT THE DEFAULT INPUT IS -1kg AND REPS=-1.


---


## Built With

* **[Flutter](https://flutter.dev/)** - Cross-platform UI toolkit.
* **[Riverpod](https://riverpod.dev/)** - Safe & reactive state management framework.
* **[Isar Database](https://isar.dev/)** - Super-fast, lightweight local NoSQL storage engine.
* **[Flutter Foreground Task](https://pub.dev/packages/flutter_foreground_task)** - Background processing service monitoring.


---


## Local Development Setup

If you want to clone this repository and contribute to the code or run it locally in debug mode, follow these setup steps:

1. Ensure you have the **Flutter SDK** installed on your system (`>=3.0.0 <4.0.
0`).

2. Clone the repository locally:
bash: git clone [https://github.com/YOUR_USERNAME/gym_planner.git](https://github.com/YOUR_USERNAME/gym_planner.git)
   cd gym_planner

3. Fetch the required dependencies:

bash: flutter pub get

4. Run the code generation engine (required for Isar collection mapping setup):

bash: dart run build_runner build --delete-conflicting-outputs

5. Launch the app on your connected device/emulator:

bash: flutter run


---


## Security & Signing Notice

This application is compiled and cryptographically signed using an independent developer certificate. The release binary configuration guarantees that the application code cannot be tampered with or modified by third parties.
