import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/theme/app_theme.dart';
import 'core/providers/settings_provider.dart';
import 'core/providers/panchang_provider.dart';
import 'features/home/home_screen.dart';
import 'l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive for offline storage
  await Hive.initFlutter();
  await Hive.openBox('settings');
  await Hive.openBox('notes');
  await Hive.openBox('reminders');

  // Prefer edge-to-edge on modern Android
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        ChangeNotifierProvider(create: (_) => PanchangProvider()),
      ],
      child: const BharatPanchangApp(),
    ),
  );
}

class BharatPanchangApp extends StatelessWidget {
  const BharatPanchangApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();

    return MaterialApp(
      title: 'Bharat Panchang Master',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(settings.largeText),
      darkTheme: AppTheme.dark(settings.largeText),
      themeMode: settings.themeMode,
      locale: settings.locale,
      supportedLocales: const [
        Locale('en'),
        Locale('hi'),
        Locale('mr'),
        Locale('gu'),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const HomeScreen(),
      builder: (context, child) {
        // Responsive text scaling + safe area handling for all devices
        final media = MediaQuery.of(context);
        return MediaQuery(
          data: media.copyWith(
            textScaler: TextScaler.linear(
              settings.largeText ? 1.25 : media.textScaler.scale(1.0).clamp(0.85, 1.4),
            ),
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}
