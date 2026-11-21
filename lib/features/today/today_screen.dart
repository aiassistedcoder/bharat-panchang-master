import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../l10n/app_localizations.dart';
import '../../core/providers/panchang_provider.dart';
import '../../core/providers/settings_provider.dart';
import '../../widgets/panchang_card.dart';
import '../../widgets/responsive_padding.dart';

class TodayScreen extends StatelessWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final panchang = context.watch<PanchangProvider>();
    final settings = context.watch<SettingsProvider>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.todaySummary),
        actions: [
          IconButton(
            icon: const Icon(Icons.today),
            onPressed: () => panchang.goToToday(),
            tooltip: l10n.today,
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // Share functionality placeholder
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.sharePanchang)),
              );
            },
          ),
        ],
      ),
      body: panchang.loading
          ? const Center(child: CircularProgressIndicator())
          : panchang.error != null
              ? Center(child: Text(panchang.error!))
              : RefreshIndicator(
                  onRefresh: () => panchang.loadForDate(panchang.selectedDate),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: ResponsivePadding(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 8),
                          // Date navigation
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.chevron_left),
                                    onPressed: panchang.previousDay,
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          DateFormat('EEEE, d MMMM yyyy', settings.locale.languageCode)
                                              .format(panchang.selectedDate),
                                          style: theme.textTheme.titleMedium,
                                          textAlign: TextAlign.center,
                                        ),
                                        Text(
                                          '${panchang.todayPanchang?.lunarMonth ?? ''} • ${panchang.todayPanchang?.paksha ?? ''}',
                                          style: theme.textTheme.bodySmall,
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.chevron_right),
                                    onPressed: panchang.nextDay,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          if (panchang.todayPanchang != null)
                            PanchangCard(panchang: panchang.todayPanchang!),
                          const SizedBox(height: 16),
                          // Festivals of the day
                          if (panchang.todayPanchang!.festivals.isNotEmpty) ...[
                            Text(l10n.festivalsTitle, style: theme.textTheme.titleMedium),
                            const SizedBox(height: 8),
                            ...panchang.todayPanchang!.festivals.map(
                              (f) => Card(
                                color: theme.colorScheme.primaryContainer,
                                child: ListTile(
                                  leading: const Icon(Icons.celebration),
                                  title: Text(f),
                                ),
                              ),
                            ),
                          ] else
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Text(l10n.noFestivals, textAlign: TextAlign.center),
                              ),
                            ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ),
    );
  }
}
