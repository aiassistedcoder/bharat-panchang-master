import 'package:flutter/material.dart';
import '../data/models/panchang_model.dart';
import '../l10n/app_localizations.dart';

class PanchangCard extends StatelessWidget {
  final PanchangModel panchang;

  const PanchangCard({super.key, required this.panchang});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.panchang, style: theme.textTheme.titleLarge),
            const Divider(),
            _row(l10n.tithi, '${panchang.tithi} (तक ${panchang.tithiEndTime})'),
            _row(l10n.nakshatra, '${panchang.nakshatra} (तक ${panchang.nakshatraEndTime})'),
            _row(l10n.yoga, panchang.yoga),
            _row(l10n.karana, panchang.karana),
            _row(l10n.vara, panchang.vara),
            const SizedBox(height: 8),
            const Divider(),
            _row(l10n.sunrise, panchang.sunrise),
            _row(l10n.sunset, panchang.sunset),
            _row(l10n.moonrise, panchang.moonrise),
            _row(l10n.moonset, panchang.moonset),
            const SizedBox(height: 8),
            const Divider(),
            _row(l10n.rahuKaal, panchang.rahuKaal, isWarning: true),
            _row(l10n.abhijitMuhurat, panchang.abhijitMuhurat, isGood: true),
            _row(l10n.brahmaMuhurta, panchang.brahmaMuhurta, isGood: true),
            const SizedBox(height: 8),
            const Divider(),
            _row(l10n.vikramSamvat, panchang.vikramSamvat),
            _row(l10n.shakaSamvat, panchang.shakaSamvat),
            const SizedBox(height: 12),
            Text(l10n.choghadiya, style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            SizedBox(
              height: 80,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: panchang.dayChoghadiya.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, i) {
                  final slot = panchang.dayChoghadiya[i];
                  return Chip(
                    label: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(slot.type, style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text('${slot.start}-${slot.end}', style: const TextStyle(fontSize: 11)),
                      ],
                    ),
                    backgroundColor: slot.isAuspicious
                        ? Colors.green.withOpacity(0.2)
                        : Colors.red.withOpacity(0.15),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value, {bool isWarning = false, bool isGood = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: isWarning
                    ? Colors.red.shade700
                    : isGood
                        ? Colors.green.shade700
                        : null,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: isWarning
                    ? Colors.red.shade700
                    : isGood
                        ? Colors.green.shade700
                        : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
