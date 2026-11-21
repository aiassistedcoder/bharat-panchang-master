class PanchangModel {
  final DateTime date;
  final String tithi;
  final String tithiEndTime;
  final String nakshatra;
  final String nakshatraEndTime;
  final String yoga;
  final String karana;
  final String vara;
  final String sunrise;
  final String sunset;
  final String moonrise;
  final String moonset;
  final String rahuKaal;
  final String abhijitMuhurat;
  final String brahmaMuhurta;
  final String vikramSamvat;
  final String shakaSamvat;
  final String paksha;
  final String lunarMonth;
  final List<String> festivals;
  final List<ChoghadiyaSlot> dayChoghadiya;
  final List<ChoghadiyaSlot> nightChoghadiya;

  PanchangModel({
    required this.date,
    required this.tithi,
    required this.tithiEndTime,
    required this.nakshatra,
    required this.nakshatraEndTime,
    required this.yoga,
    required this.karana,
    required this.vara,
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
    required this.rahuKaal,
    required this.abhijitMuhurat,
    required this.brahmaMuhurta,
    required this.vikramSamvat,
    required this.shakaSamvat,
    required this.paksha,
    required this.lunarMonth,
    required this.festivals,
    required this.dayChoghadiya,
    required this.nightChoghadiya,
  });
}

class ChoghadiyaSlot {
  final String name;
  final String type; // Amrit, Shubh, Labh, Char, Rog, Kaal, Udveg
  final String start;
  final String end;
  final bool isAuspicious;

  ChoghadiyaSlot({
    required this.name,
    required this.type,
    required this.start,
    required this.end,
    required this.isAuspicious,
  });
}

class FestivalModel {
  final String id;
  final String nameEn;
  final String nameHi;
  final String nameMr;
  final String nameGu;
  final DateTime date;
  final String category; // Hindu, Islamic, Christian, National, Regional
  final String description;
  final bool isVrat;

  FestivalModel({
    required this.id,
    required this.nameEn,
    required this.nameHi,
    required this.nameMr,
    required this.nameGu,
    required this.date,
    required this.category,
    required this.description,
    this.isVrat = false,
  });
}
