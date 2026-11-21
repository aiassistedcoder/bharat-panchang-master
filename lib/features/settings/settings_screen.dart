import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../l10n/app_localizations.dart';
import '../../core/providers/settings_provider.dart';
import '../../widgets/responsive_padding.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final settings = context.watch<SettingsProvider>();

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: ResponsivePadding(
        child: ListView(
          children: [
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(Icons.language),
              title: Text(l10n.language),
              subtitle: Text(_langName(settings.locale.languageCode, l10n)),
              onTap: () => _showLanguageDialog(context, settings, l10n),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.palette_outlined),
              title: Text(l10n.theme),
              subtitle: Text(_themeName(settings.themeMode, l10n)),
              onTap: () => _showThemeDialog(context, settings, l10n),
            ),
            SwitchListTile(
              secondary: const Icon(Icons.text_fields),
              title: Text(l10n.largeText),
              value: settings.largeText,
              onChanged: settings.setLargeText,
            ),
            SwitchListTile(
              secondary: const Icon(Icons.numbers),
              title: const Text('Indic Numerals'),
              value: settings.useIndicNumerals,
              onChanged: settings.setIndicNumerals,
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.location_on_outlined),
              title: Text(l10n.location),
              subtitle: Text(settings.city),
              onTap: () {
                // City picker placeholder
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('City database with 500+ cities – expand in production')),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
              subtitle: const Text('Bharat Panchang Master v1.0.0'),
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: 'Bharat Panchang Master',
                  applicationVersion: '1.0.0',
                  applicationLegalese: 'Offline-first • Privacy focused\nInspired by Kalnirnay + modern Panchang apps',
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                l10n.privacyNote,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _langName(String code, AppLocalizations l10n) {
    return switch (code) {
      'hi' => l10n.hindi,
      'mr' => l10n.marathi,
      'gu' => l10n.gujarati,
      _ => l10n.english,
    };
  }

  String _themeName(ThemeMode mode, AppLocalizations l10n) {
    return switch (mode) {
      ThemeMode.light => l10n.lightMode,
      ThemeMode.dark => l10n.darkMode,
      _ => l10n.systemMode,
    };
  }

  void _showLanguageDialog(BuildContext context, SettingsProvider settings, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (_) => SimpleDialog(
        title: Text(l10n.selectLanguage),
        children: [
          _langOption(context, settings, 'en', l10n.english),
          _langOption(context, settings, 'hi', l10n.hindi),
          _langOption(context, settings, 'mr', l10n.marathi),
          _langOption(context, settings, 'gu', l10n.gujarati),
        ],
      ),
    );
  }

  Widget _langOption(BuildContext context, SettingsProvider settings, String code, String name) {
    return SimpleDialogOption(
      onPressed: () {
        settings.setLanguage(code);
        Navigator.pop(context);
      },
      child: Text(name),
    );
  }

  void _showThemeDialog(BuildContext context, SettingsProvider settings, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (_) => SimpleDialog(
        title: Text(l10n.theme),
        children: [
          SimpleDialogOption(
            onPressed: () {
              settings.setThemeMode(ThemeMode.light);
              Navigator.pop(context);
            },
            child: Text(l10n.lightMode),
          ),
          SimpleDialogOption(
            onPressed: () {
              settings.setThemeMode(ThemeMode.dark);
              Navigator.pop(context);
            },
            child: Text(l10n.darkMode),
          ),
          SimpleDialogOption(
            onPressed: () {
              settings.setThemeMode(ThemeMode.system);
              Navigator.pop(context);
            },
            child: Text(l10n.systemMode),
          ),
        ],
      ),
    );
  }
}
