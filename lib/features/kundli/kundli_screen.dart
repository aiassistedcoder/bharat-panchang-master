import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../widgets/responsive_padding.dart';

class KundliScreen extends StatefulWidget {
  const KundliScreen({super.key});

  @override
  State<KundliScreen> createState() => _KundliScreenState();
}

class _KundliScreenState extends State<KundliScreen> {
  final _nameCtrl = TextEditingController();
  DateTime? _birthDate;
  TimeOfDay? _birthTime;
  String _chartStyle = 'North';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.kundli)),
      body: ResponsivePadding(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Janam Kundli Generator',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                l10n.privacyNote,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _nameCtrl,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                title: Text(_birthDate == null
                    ? 'Select Birth Date'
                    : '${_birthDate!.day}/${_birthDate!.month}/${_birthDate!.year}'),
                leading: const Icon(Icons.calendar_today),
                trailing: const Icon(Icons.chevron_right),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.grey.shade400),
                ),
                onTap: () async {
                  final d = await showDatePicker(
                    context: context,
                    initialDate: DateTime(1990),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (d != null) setState(() => _birthDate = d);
                },
              ),
              const SizedBox(height: 12),
              ListTile(
                title: Text(_birthTime == null
                    ? 'Select Birth Time'
                    : _birthTime!.format(context)),
                leading: const Icon(Icons.access_time),
                trailing: const Icon(Icons.chevron_right),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.grey.shade400),
                ),
                onTap: () async {
                  final t = await showTimePicker(
                    context: context,
                    initialTime: const TimeOfDay(hour: 12, minute: 0),
                  );
                  if (t != null) setState(() => _birthTime = t);
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _chartStyle,
                decoration: const InputDecoration(
                  labelText: 'Chart Style',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'North', child: Text('North Indian')),
                  DropdownMenuItem(value: 'South', child: Text('South Indian')),
                  DropdownMenuItem(value: 'East', child: Text('East Indian')),
                ],
                onChanged: (v) => setState(() => _chartStyle = v ?? 'North'),
              ),
              const SizedBox(height: 32),
              FilledButton.icon(
                onPressed: () {
                  if (_birthDate == null || _birthTime == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please select date & time')),
                    );
                    return;
                  }
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Kundli Preview'),
                      content: Text(
                        'Name: ${_nameCtrl.text}\n'
                        'Date: ${_birthDate!.day}/${_birthDate!.month}/${_birthDate!.year}\n'
                        'Time: ${_birthTime!.format(context)}\n'
                        'Style: $_chartStyle\n\n'
                        'Full planetary calculation & Dasha will be available after integrating Swiss Ephemeris / real engine.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Close'),
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.auto_awesome),
                label: const Text('Generate Kundli'),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
              const SizedBox(height: 24),
              OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Guna Milan feature – coming in next version')),
                  );
                },
                icon: const Icon(Icons.favorite),
                label: const Text('Guna Milan (Matchmaking)'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
