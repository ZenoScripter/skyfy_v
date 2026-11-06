# SKYFY — petunjuk build

Project ini adalah aplikasi Flutter Android. Folder `lib/services`, `lib/database`, `lib/models`, `lib/utilities`, `packages`, dan konfigurasi native dipertahankan dari source Musify yang disediakan agar fitur inti tetap terhubung.

## Build lokal

Gunakan Flutter SDK yang memenuhi constraint pada `pubspec.yaml` (Flutter 3.47.9 atau kompatibel dengan Dart >=3.13), Android SDK, dan JDK 17.

```bash
flutter pub get
flutter run
```

Untuk APK release:

```bash
flutter build apk --flavor github --release
```

Output normal berada di `build/app/outputs/flutter-apk/`.

Catatan: build APK belum dijalankan di lingkungan penyusunan ini. Jalankan perintah di atas di komputer/lingkungan yang memiliki Flutter dan Android SDK.
