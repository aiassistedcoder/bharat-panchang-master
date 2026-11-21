import 'package:flutter/material.dart';
import '../../data/models/panchang_model.dart';
import '../../data/repositories/panchang_repository.dart';

class PanchangProvider extends ChangeNotifier {
  final PanchangRepository _repo = PanchangRepository();

  DateTime _selectedDate = DateTime.now();
  PanchangModel? _todayPanchang;
  bool _loading = false;
  String? _error;

  DateTime get selectedDate => _selectedDate;
  PanchangModel? get todayPanchang => _todayPanchang;
  bool get loading => _loading;
  String? get error => _error;

  PanchangProvider() {
    loadForDate(DateTime.now());
  }

  Future<void> loadForDate(DateTime date) async {
    _loading = true;
    _error = null;
    _selectedDate = date;
    notifyListeners();

    try {
      _todayPanchang = await _repo.getPanchang(date);
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  void nextDay() {
    loadForDate(_selectedDate.add(const Duration(days: 1)));
  }

  void previousDay() {
    loadForDate(_selectedDate.subtract(const Duration(days: 1)));
  }

  void goToToday() {
    loadForDate(DateTime.now());
  }
}
