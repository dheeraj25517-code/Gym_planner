# Gym Planner 

A minimal, lightning-fast workout tracking application built with Flutter. Optimized with a dark theme aesthetic, this app helps you plan your gym sessions, track your historical sets, and manage your rest intervals without distractions.

# Preview

<img width="380" height="1678" alt="Screenshot_2026-06-24-14-03-58-51_d33be566b4588b842e911e87f85c1d7f" src="https://github.com/user-attachments/assets/30cc286c-4523-486f-9d1e-318c6758b67b" />

<img width="1080" height="2378" alt="Screenshot_2026-06-24-16-18-01-49_d33be566b4588b842e911e87f85c1d7f" src="https://github.com/user-attachments/assets/210164a0-7435-473e-afed-b3e9642b741f" />

<img width="1080" height="2378" alt="Screenshot_2026-06-24-16-18-14-44_d33be566b4588b842e911e87f85c1d7f" src="https://github.com/user-attachments/assets/28e2129e-0898-4b6a-9634-f949fe911eee" />

<img width="1080" height="2378" alt="Screenshot_2026-06-24-16-18-21-66_d33be566b4588b842e911e87f85c1d7f" src="https://github.com/user-attachments/assets/b5ed638d-352f-40a9-8d8e-f2fb038bfbfc" />

<img width="1080" height="2378" alt="Screenshot_2026-06-24-16-18-45-44_d33be566b4588b842e911e87f85c1d7f" src="https://github.com/user-attachments/assets/59c8ec9c-69fd-46cd-a6dd-2940c4f69be5" />

<img width="1080" height="2378" alt="Screenshot_2026-06-24-16-18-49-16_d33be566b4588b842e911e87f85c1d7f" src="https://github.com/user-attachments/assets/77415278-2347-4e1c-9b5e-57d784fb8fbf" />

<img width="1080" height="2378" alt="Screenshot_2026-06-24-16-19-53-37_d33be566b4588b842e911e87f85c1d7f" src="https://github.com/user-attachments/assets/e0131419-25a1-456c-89b2-72fc2b331897" />

<img width="1080" height="2378" alt="Screenshot_2026-06-24-16-21-19-73_d33be566b4588b842e911e87f85c1d7f" src="https://github.com/user-attachments/assets/e2b7f454-6b2d-42f2-8250-da4a71664838" />



---


## Features
* Global Cart State Management: Built using Riverpod, users can browse exercises or routine templates and add them to a centralized "Workout Cart" or active queue from any screen without losing state or data continuity.
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
