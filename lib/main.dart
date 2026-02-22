import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'core/theme.dart';
import 'providers/adhkar_provider.dart';
import 'providers/hadith_provider.dart';
import 'providers/settings_provider.dart';
import 'screens/home_screen.dart';
import 'services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Allow Google Fonts to fetch from local cache when offline
  GoogleFonts.config.allowRuntimeFetching = true;

  // Initialize notification service on native platforms
  if (!kIsWeb) {
    await NotificationService().initialize();
  }

  runApp(const DailyZikrApp());
}

class DailyZikrApp extends StatelessWidget {
  const DailyZikrApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AdhkarProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        ChangeNotifierProvider(create: (_) => HadithProvider()),
      ],
      child: Consumer<SettingsProvider>(
        builder: (context, settingsProvider, child) {
          return MaterialApp(
            title: 'Daily Zikr',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: settingsProvider.materialThemeMode,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
