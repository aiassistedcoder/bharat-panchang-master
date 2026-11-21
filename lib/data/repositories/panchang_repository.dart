import '../models/panchang_model.dart';

/// Offline Panchang repository.
/// In production replace the sample generator with real Swiss Ephemeris / Drik calculations.
class PanchangRepository {
  Future<PanchangModel> getPanchang(DateTime date) async {
    // Simulate calculation delay
    await Future.delayed(const Duration(milliseconds: 180));

    // Sample data – replace with real astronomical engine
    final tithis = [
      'प्रतिपदा', 'द्वितीया', 'तृतीया', 'चतुर्थी', 'पंचमी',
      'षष्ठी', 'सप्तमी', 'अष्टमी', 'नवमी', 'दशमी',
      'एकादशी', 'द्वादशी', 'त्रयोदशी', 'चतुर्दशी', 'पूर्णिमा', 'अमावस्या'
    ];
    final nakshatras = [
      'अश्विनी', 'भरणी', 'कृत्तिका', 'रोहिणी', 'मृगशिरा', 'आर्द्रा',
      'पुनर्वसु', 'पुष्य', 'आश्लेषा', 'मघा', 'पूर्वा फाल्गुनी', 'उत्तरा फाल्गुनी',
      'हस्त', 'चित्रा', 'स्वाती', 'विशाखा', 'अनुराधा', 'ज्येष्ठा',
      'मूल', 'पूर्वाषाढ़ा', 'उत्तराषाढ़ा', 'श्रवण', 'धनिष्ठा', 'शतभिषा',
      'पूर्वा भाद्रपद', 'उत्तरा भाद्रपद', 'रेवती'
    ];
    final yogas = [
      'विष्कम्भ', 'प्रीति', 'आयुष्मान', 'सौभाग्य', 'शोभन', 'अतिगंड',
      'सुकर्मा', 'धृति', 'शूल', 'गंड', 'वृद्धि', 'ध्रुव', 'व्याघात',
      'हर्षण', 'वज्र', 'सिद्धि', 'व्यतीपात', 'वरीयान', 'परिघ',
      'शिव', 'सिद्ध', 'साध्य', 'शुभ', 'शुक्ल', 'ब्रह्म', 'इन्द्र', 'वैधृति'
    ];
    final karanas = [
      'बव', 'बालव', 'कौलव', 'तैतिल', 'गर', 'वणिज', 'विष्टि',
      'शकुनि', 'चतुष्पाद', 'नाग', 'किंस्तुघ्न'
    ];
    final varas = ['रविवार', 'सोमवार', 'मंगलवार', 'बुधवार', 'गुरुवार', 'शुक्रवार', 'शनिवार'];

    final dayIndex = date.day % tithis.length;
    final nakIndex = (date.day + date.month) % nakshatras.length;

    return PanchangModel(
      date: date,
      tithi: tithis[dayIndex],
      tithiEndTime: '14:32',
      nakshatra: nakshatras[nakIndex],
      nakshatraEndTime: '18:45',
      yoga: yogas[(date.day * 2) % yogas.length],
      karana: karanas[date.day % karanas.length],
      vara: varas[date.weekday % 7],
      sunrise: '06:42',
      sunset: '18:15',
      moonrise: '20:10',
      moonset: '08:55',
      rahuKaal: '10:30 – 12:00',
      abhijitMuhurat: '11:48 – 12:36',
      brahmaMuhurta: '05:00 – 05:48',
      vikramSamvat: '2083',
      shakaSamvat: '1948',
      paksha: dayIndex < 15 ? 'शुक्ल पक्ष' : 'कृष्ण पक्ष',
      lunarMonth: 'कार्तिक',
      festivals: _getFestivalsForDate(date),
      dayChoghadiya: _sampleChoghadiya(true),
      nightChoghadiya: _sampleChoghadiya(false),
    );
  }

  List<String> _getFestivalsForDate(DateTime date) {
    // Sample festivals for demo (2026-2027 focus)
    if (date.month == 11 && date.day == 16) return ['गुरु नानक जयंती'];
    if (date.month == 10 && date.day == 20) return ['दीपावली'];
    if (date.month == 3 && date.day == 14) return ['होली'];
    if (date.month == 8 && date.day == 26) return ['जन्माष्टमी'];
    if (date.weekday == 1) return ['सोमवती अमावस्या (नमूना)'];
    return [];
  }

  List<ChoghadiyaSlot> _sampleChoghadiya(bool isDay) {
    final types = [
      ('अमृत', true),
      ('शुभ', true),
      ('लाभ', true),
      ('चर', true),
      ('रोग', false),
      ('काल', false),
      ('उद्वेग', false),
    ];
    return List.generate(8, (i) {
      final t = types[i % types.length];
      final startH = isDay ? 6 + i : 18 + (i % 6);
      return ChoghadiyaSlot(
        name: 'चौघड़िया ${i + 1}',
        type: t.$1,
        start: '${startH.toString().padLeft(2, '0')}:00',
        end: '${(startH + 1).toString().padLeft(2, '0')}:30',
        isAuspicious: t.$2,
      );
    });
  }

  Future<List<FestivalModel>> getFestivals({int year = 2026}) async {
    // Sample festival list – expand with full database
    return [
      FestivalModel(
        id: 'diwali2026',
        nameEn: 'Diwali',
        nameHi: 'दीपावली',
        nameMr: 'दिवाळी',
        nameGu: 'દીવાળી',
        date: DateTime(2026, 11, 8),
        category: 'Hindu',
        description: 'Festival of lights. Lakshmi Puja in the evening.',
        isVrat: false,
      ),
      FestivalModel(
        id: 'holi2027',
        nameEn: 'Holi',
        nameHi: 'होली',
        nameMr: 'होळी',
        nameGu: 'હોળી',
        date: DateTime(2027, 3, 3),
        category: 'Hindu',
        description: 'Festival of colours.',
      ),
      FestivalModel(
        id: 'republic2026',
        nameEn: 'Republic Day',
        nameHi: 'गणतंत्र दिवस',
        nameMr: 'प्रजासत्ताक दिन',
        nameGu: 'પ્રજાસત્તાક દિવસ',
        date: DateTime(2026, 1, 26),
        category: 'National',
        description: 'National holiday.',
      ),
      FestivalModel(
        id: 'eid2026',
        nameEn: 'Eid-ul-Fitr',
        nameHi: 'ईद उल-फ़ित्र',
        nameMr: 'ईद उल-फितर',
        nameGu: 'ઈદ ઉલ-ફિતર',
        date: DateTime(2026, 3, 21),
        category: 'Islamic',
        description: 'End of Ramadan.',
      ),
    ];
  }
}
