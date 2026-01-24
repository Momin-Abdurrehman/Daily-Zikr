import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'core/theme.dart';
import 'providers/adhkar_provider.dart';
import 'providers/settings_provider.dart';
import 'screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Allow Google Fonts to fetch from local cache when offline
  GoogleFonts.config.allowRuntimeFetching = true;
  
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
