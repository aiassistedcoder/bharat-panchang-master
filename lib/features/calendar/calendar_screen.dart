import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';
import '../../l10n/app_localizations.dart';
import '../../core/providers/panchang_provider.dart';
import '../../widgets/responsive_padding.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _format = CalendarFormat.month;
  DateTime _focused = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final panchang = context.read<PanchangProvider>();

    return Scaffold(
      appBar: AppBar(title: Text(l10n.calendar)),
      body: ResponsivePadding(
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime(1900),
              lastDay: DateTime(2100),
              focusedDay: _focused,
              calendarFormat: _format,
              selectedDayPredicate: (day) => isSameDay(day, panchang.selectedDate),
              onDaySelected: (selected, focused) {
                setState(() => _focused = focused);
                panchang.loadForDate(selected);
              },
              onFormatChanged: (f) => setState(() => _format = f),
              onPageChanged: (f) => _focused = f,
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                ),
                markerDecoration: const BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
              ),
              headerStyle: const HeaderStyle(
                formatButtonVisible: true,
                titleCentered: true,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selected: ${panchang.selectedDate.day}/${panchang.selectedDate.month}/${panchang.selectedDate.year}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      if (panchang.todayPanchang != null) ...[
                        Text('${l10n.tithi}: ${panchang.todayPanchang!.tithi}'),
                        Text('${l10n.nakshatra}: ${panchang.todayPanchang!.nakshatra}'),
                        if (panchang.todayPanchang!.festivals.isNotEmpty)
                          Text('${l10n.festivals}: ${panchang.todayPanchang!.festivals.join(", ")}'),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
