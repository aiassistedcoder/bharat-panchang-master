import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../l10n/app_localizations.dart';
import '../../core/providers/settings_provider.dart';
import '../today/today_screen.dart';
import '../calendar/calendar_screen.dart';
import '../festivals/festivals_screen.dart';
import '../kundli/kundli_screen.dart';
import '../settings/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final _pages = const [
    TodayScreen(),
    CalendarScreen(),
    FestivalsScreen(),
    KundliScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final settings = context.watch<SettingsProvider>();

    // Responsive: use NavigationBar on modern, fallback for older
    final isWide = MediaQuery.sizeOf(context).width >= 600;

    return Scaffold(
      body: SafeArea(
        child: isWide
            ? Row(
                children: [
                  NavigationRail(
                    selectedIndex: _currentIndex,
                    onDestinationSelected: (i) => setState(() => _currentIndex = i),
                    labelType: NavigationRailLabelType.all,
                    destinations: [
                      NavigationRailDestination(
                        icon: const Icon(Icons.wb_sunny_outlined),
                        selectedIcon: const Icon(Icons.wb_sunny),
                        label: Text(l10n.today),
                      ),
                      NavigationRailDestination(
                        icon: const Icon(Icons.calendar_month_outlined),
                        selectedIcon: const Icon(Icons.calendar_month),
                        label: Text(l10n.calendar),
                      ),
                      NavigationRailDestination(
                        icon: const Icon(Icons.celebration_outlined),
                        selectedIcon: const Icon(Icons.celebration),
                        label: Text(l10n.festivals),
                      ),
                      NavigationRailDestination(
                        icon: const Icon(Icons.auto_awesome_outlined),
                        selectedIcon: const Icon(Icons.auto_awesome),
                        label: Text(l10n.kundli),
                      ),
                      NavigationRailDestination(
                        icon: const Icon(Icons.settings_outlined),
                        selectedIcon: const Icon(Icons.settings),
                        label: Text(l10n.settings),
                      ),
                    ],
                  ),
                  const VerticalDivider(width: 1),
                  Expanded(child: _pages[_currentIndex]),
                ],
              )
            : _pages[_currentIndex],
      ),
      bottomNavigationBar: isWide
          ? null
          : NavigationBar(
              selectedIndex: _currentIndex,
              onDestinationSelected: (i) => setState(() => _currentIndex = i),
              destinations: [
                NavigationDestination(
                  icon: const Icon(Icons.wb_sunny_outlined),
                  selectedIcon: const Icon(Icons.wb_sunny),
                  label: l10n.today,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.calendar_month_outlined),
                  selectedIcon: const Icon(Icons.calendar_month),
                  label: l10n.calendar,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.celebration_outlined),
                  selectedIcon: const Icon(Icons.celebration),
                  label: l10n.festivals,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.auto_awesome_outlined),
                  selectedIcon: const Icon(Icons.auto_awesome),
                  label: l10n.kundli,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.settings_outlined),
                  selectedIcon: const Icon(Icons.settings),
                  label: l10n.settings,
                ),
              ],
            ),
    );
  }
}
