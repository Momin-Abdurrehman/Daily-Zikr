# Daily Zikr

A beautiful Islamic app for morning and evening remembrances (adhkar), built with Flutter.

Stay consistent with your daily supplications, track your progress, and build a streak of spiritual discipline.

## Features

- **Morning & Evening Adhkar** — 19 authentic supplications for each session, sourced from the Quran and Sunnah with full references
- **Arabic Text & Translation** — Each dhikr includes Arabic text, transliteration, and English translation
- **Virtues (Fazail)** — Expandable section showing the reward and virtue of each supplication
- **Custom Duas** — Add your own personal supplications to the list
- **Reorderable List** — Drag-and-drop to arrange supplications in your preferred order
- **Hide & Restore** — Temporarily hide supplications you don't need and restore them anytime
- **Daily Hadith** — A rotating daily hadith on the home screen
- **Streak Tracking** — Track consecutive days of completing both morning and evening adhkar
- **Dark Mode** — Full light and dark theme support
- **Arabic Font Options** — Choose between Nastaliq and Naskh Arabic script styles
- **Notifications** — Morning and evening reminders (mobile only)
- **Cross-Platform** — Runs on Android, iOS, Web, macOS, and more

## Screenshots

*Coming soon*

## Getting Started

### Prerequisites

- Flutter SDK 3.10.7 or later
- Dart SDK

### Run the app

```bash
# Get dependencies
flutter pub get

# Run on Chrome
flutter run -d chrome

# Build Android APK
flutter build apk --release

# Build for iOS
flutter build ios --release
```

## Project Structure

```
lib/
  core/         Constants and theme configuration
  data/         Static adhkar and hadith data
  models/       Dhikr and Hadith data models
  providers/    State management (Provider/ChangeNotifier)
  screens/      App screens (Home, Adhkar List, Settings, etc.)
  services/     Notification service
  widgets/      Reusable widgets (DhikrCard, ProgressHeader, etc.)
```

## Tech Stack

- **Flutter** — Cross-platform UI framework
- **Provider** — State management
- **SharedPreferences** — Local persistence for settings, custom duas, and order
- **Hijri** — Islamic (Hijri) calendar date display

## Version History

### v1.2.0
- Fixed scroll/drag conflict on mobile — scrolling no longer accidentally reorders cards
- Drag handle moved to left side for better reachability
- Fixed header layout overflow on smaller screens
- Reordered default adhkar for improved flow
- Version display updated in settings

### v1.1.0
- Hide and restore built-in adhkar
- Custom dhikr management (add, delete, reorder)
- Splash screen for web

### v1.0.0
- Initial release with morning and evening adhkar
- Daily hadith, streak tracking, dark mode, notifications

## License

This project is private and not open-sourced.

---

*May Allah accept our remembrance and grant us steadfastness.*
