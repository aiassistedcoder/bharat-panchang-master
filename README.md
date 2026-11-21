# Bharat Panchang Master

**Comprehensive Indian Panchang & Multi-Language Calendar App**  
Inspired by Kalnirnay + modern offline Panchang apps.

Supports **Hindi • Marathi • Gujarati • English** with architecture ready for more Indian languages.

---

## Features Implemented (v1.0 Skeleton)

- Offline-first architecture
- Multi-language UI (en / hi / mr / gu)
- Material Design 3 + Light / Dark / System themes
- Senior-friendly Large Text mode
- Responsive layout (phones, foldables, tablets)
- Today Panchang view (Tithi, Nakshatra, Yoga, Karana, timings, Choghadiya)
- Month calendar with date selection
- Festivals list with search & categories
- Kundli form (ready for real engine)
- Settings (language, theme, location placeholder)
- Privacy-first design

> **Note**: Real Swiss Ephemeris / Drik Panchang calculations are stubbed with sample data. Replace `PanchangRepository` with a real astronomy engine for production accuracy.

---

## Broad Android Compatibility

| Setting              | Value      | Coverage                          |
|----------------------|------------|-----------------------------------|
| minSdk               | 21 (Android 5.0) | ~99%+ of active devices         |
| targetSdk            | 35 (Android 15)  | Latest security & features      |
| Screen support       | all densities + sizes | phones, tablets, foldables     |
| Architecture         | Flutter    | single APK for all ABIs          |

Flutter automatically generates fat APK or App Bundle that works across:
- ldpi / mdpi / hdpi / xhdpi / xxhdpi / xxxhdpi
- Small / Normal / Large / XLarge screens
- Portrait & Landscape
- Different aspect ratios (including foldables)

---

## How to Build the APK

### Prerequisites
1. Install [Flutter SDK](https://docs.flutter.dev/get-started/install) (3.16+)
2. Install Android Studio + Android SDK
3. Accept licenses: `flutter doctor --android-licenses`

### Steps

```bash
# 1. Clone / copy this project
cd bharat_panchang_master

# 2. Get dependencies
flutter pub get

# 3. Generate localizations
flutter gen-l10n

# 4. (Optional) Run on connected device / emulator
flutter run

# 5. Build release APK (universal – works on all architectures)
flutter build apk --release

# Output: build/app/outputs/flutter-apk/app-release.apk
```

### Split APKs by ABI (smaller downloads)
```bash
flutter build apk --split-per-abi --release
```

### App Bundle (recommended for Play Store)
```bash
flutter build appbundle --release
```

### Signed Release (Production)
1. Create a keystore:
   ```bash
   keytool -genkey -v -keystore ~/bharat-panchang.jks -keyalg RSA -keysize 2048 -validity 10000 -alias bharat
   ```
2. Create `android/key.properties`
3. Update `android/app/build.gradle` signingConfigs
4. Build again

---

## Project Structure

```
lib/
├── main.dart
├── core/
│   ├── theme/
│   └── providers/
├── data/
│   ├── models/
│   └── repositories/
├── domain/
├── features/
│   ├── today/
│   ├── calendar/
│   ├── festivals/
│   ├── kundli/
│   ├── settings/
│   └── home/
├── l10n/          # English, Hindi, Marathi, Gujarati
├── widgets/
└── utils/
```

---

## Next Steps for Production

1. Integrate real Panchang engine (Swiss Ephemeris via FFI or pure Dart port / Drik Panchang rules)
2. Expand festival database for 2026–2030+
3. Add offline city database (500+ Indian cities)
4. Implement home-screen widgets
5. Full notification system for festivals & muhurats
6. Guna Milan + advanced Kundli charts
7. Add more languages (Tamil, Telugu, Kannada, Malayalam, Bengali…)
8. Play Store listing + screenshots

---

## License & Credits

Built as an open project combining the spirit of Kalnirnay with modern Flutter practices.  
Use freely for personal or commercial purposes. Attribution appreciated.
