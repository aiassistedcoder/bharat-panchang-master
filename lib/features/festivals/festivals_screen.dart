import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../l10n/app_localizations.dart';
import '../../core/providers/settings_provider.dart';
import '../../data/models/panchang_model.dart';
import '../../data/repositories/panchang_repository.dart';
import '../../widgets/responsive_padding.dart';

class FestivalsScreen extends StatefulWidget {
  const FestivalsScreen({super.key});

  @override
  State<FestivalsScreen> createState() => _FestivalsScreenState();
}

class _FestivalsScreenState extends State<FestivalsScreen> {
  final _repo = PanchangRepository();
  List<FestivalModel> _festivals = [];
  String _query = '';
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final list = await _repo.getFestivals(year: 2026);
    setState(() {
      _festivals = list;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final settings = context.watch<SettingsProvider>();
    final filtered = _festivals.where((f) {
      if (_query.isEmpty) return true;
      final q = _query.toLowerCase();
      return f.nameEn.toLowerCase().contains(q) ||
          f.nameHi.contains(q) ||
          f.nameMr.contains(q) ||
          f.nameGu.contains(q);
    }).toList();

    return Scaffold(
      appBar: AppBar(title: Text(l10n.festivalsTitle)),
      body: ResponsivePadding(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                decoration: InputDecoration(
                  hintText: l10n.searchFestivals,
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onChanged: (v) => setState(() => _query = v),
              ),
            ),
            Expanded(
              child: _loading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: filtered.length,
                      itemBuilder: (context, i) {
                        final f = filtered[i];
                        final name = switch (settings.locale.languageCode) {
                          'hi' => f.nameHi,
                          'mr' => f.nameMr,
                          'gu' => f.nameGu,
                          _ => f.nameEn,
                        };
                        return Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: _categoryColor(f.category),
                              child: Text(
                                f.category[0],
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            title: Text(name),
                            subtitle: Text(
                              '${f.date.day}/${f.date.month}/${f.date.year} • ${f.category}',
                            ),
                            trailing: f.isVrat
                                ? const Chip(label: Text('Vrat', style: TextStyle(fontSize: 11)))
                                : null,
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: Text(name),
                                  content: Text(f.description),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Color _categoryColor(String cat) {
    return switch (cat) {
      'Hindu' => Colors.orange,
      'Islamic' => Colors.green,
      'Christian' => Colors.blue,
      'National' => Colors.indigo,
      _ => Colors.grey,
    };
  }
}
