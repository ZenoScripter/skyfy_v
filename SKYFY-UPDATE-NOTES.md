# SKYFY visual update

This update adds:
- A custom SKYFY textured background asset used on Home, Profile, and Now Playing.
- Flutter's DEBUG ribbon disabled (`debugShowCheckedModeBanner: false`).
- Profile editing with a locally persisted display name and image path (Hive + file_picker).
- Sponsor section removed from Settings.
- License/About entries removed from the Settings "Others" list and replaced with "Aku".
- Debug APK artifact renamed to `SKYFY-debug.apk`.
- Home app mark changed to a clearer wave icon.

The existing audio, search, playlist, download, and navigation services are retained.
Build verification was not run in this environment because Flutter/Dart SDK are unavailable.
