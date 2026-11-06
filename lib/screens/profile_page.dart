/*
 * SKYFY profile hub. Profile preferences are stored locally in Hive.
 */
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:material_ui/material_ui.dart';
import 'package:path_provider/path_provider.dart';

const _profileBg = Color(0xFF080610);
const _profileSurface = Color(0xFF171126);
const _profilePurple = Color(0xFFA778FF);
const _profileMuted = Color(0xFFAAA1BC);

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final Box _settings;
    String? _avatarPath;

  @override
  void initState() {
    super.initState();
    _settings = Hive.box('settings');
    _avatarPath = _settings.get('skyfyProfileAvatar');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _profileBg,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/skyfy_background.jpg'),
            fit: BoxFit.cover,
            opacity: 0.16,
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(22, 18, 22, 22),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    children: [
                      const Text(
                        'Profile',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const Spacer(),
                      _iconButton(
                        Icons.settings_outlined,
                        () => context.push('/settings/preferences'),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(22, 4, 22, 26),
                sliver: SliverToBoxAdapter(child: _profileHeader()),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    children: [
                      _group([
                        _item(Icons.person_outline_rounded, 'Edit Profil',
                            'Ubah foto profil', _editProfile),
                        _item(Icons.palette_outlined, 'Appearance',
                            'Tema, warna, dan tampilan',
                            () => context.push('/settings/preferences')),
                        _item(Icons.equalizer_rounded, 'Playback',
                            'Kualitas audio & pemutaran',
                            () => context.push('/settings/equalizer')),
                        _item(Icons.download_outlined, 'Download',
                            'Lokasi, kualitas, dan penyimpanan',
                            () => context.push('/settings/preferences')),
                        _item(Icons.info_outline_rounded, 'Informasi & Developer',
                            'Versi aplikasi dan informasi SKYFY',
                            () => context.push('/settings/about')),
                      ]),
                      const SizedBox(height: 18),
                      _group([
                        _item(Icons.favorite_border_rounded, 'Liked Songs',
                            'Koleksi lagu favorit', () => context.go('/library')),
                        _item(Icons.library_music_outlined, 'Your Library',
                            'Playlist dan musik tersimpan',
                            () => context.go('/library')),
                      ]),
                      const SizedBox(height: 22),
                      const Text('SKYFY MUSIC', style: TextStyle(
                        color: _profileMuted, fontSize: 9, letterSpacing: 1.1,
                      )),
                      const SizedBox(height: 22),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileHeader() => Column(
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.94, end: 1),
            duration: const Duration(milliseconds: 420),
            curve: Curves.easeOutCubic,
            builder: (context, scale, child) =>
                Transform.scale(scale: scale, child: child),
            child: GestureDetector(
              onTap: _editProfile,
              child: Container(
                width: 112,
                height: 112,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [_profilePurple, Color(0xFF34204F)],
                  ),
                  border: Border.all(color: _profilePurple.withOpacity(.75), width: 2),
                  boxShadow: [BoxShadow(
                    color: _profilePurple.withOpacity(.22),
                    blurRadius: 30,
                    spreadRadius: 2,
                  )],
                ),
                clipBehavior: Clip.antiAlias,
                child: _avatarPath != null && File(_avatarPath!).existsSync()
                    ? Image.file(File(_avatarPath!), fit: BoxFit.cover)
                    : const Icon(Icons.person_rounded, color: Colors.white, size: 58),
              ),
            ),
          ),
          const SizedBox(height: 13),
          const SizedBox(height: 5),          const Text('Your music space', style: TextStyle(color: _profileMuted, fontSize: 12)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
            decoration: BoxDecoration(
              color: _profilePurple.withOpacity(.13),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: _profilePurple.withOpacity(.3)),
            ),
            child: const Text('SKYFY MEMBER', style: TextStyle(
              color: Color(0xFFD8C4FF), fontSize: 9, letterSpacing: 1.4,
              fontWeight: FontWeight.w800,
            )),
          ),
        ],
      );

  Future<String?> _pickAndPersistAvatar() async {
    final picked = await FilePicker.pickFile(type: FileType.image);
    final sourcePath = picked?.path;
    if (sourcePath == null || sourcePath.isEmpty) return null;
    final source = File(sourcePath);
    if (!await source.exists()) return null;
    final directory = await getApplicationDocumentsDirectory();
    final extension = sourcePath.contains('.')
        ? sourcePath.substring(sourcePath.lastIndexOf('.'))
        : '.jpg';
    final destination = File('${directory.path}/skyfy_profile_avatar$extension');
    await source.copy(destination.path);
    return destination.path;
  }

  Future<void> _editProfile() async {
    String? selectedAvatar = _avatarPath;
    String? result;

    try {
      result = await showDialog<String?>(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) => StatefulBuilder(
          builder: (context, setDialogState) => AlertDialog(
            backgroundColor: _profileSurface,
            title: const Text('Edit Profil', style: TextStyle(color: Colors.white)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () async {
                    try {
                      final path = await _pickAndPersistAvatar();
                      if (path != null && dialogContext.mounted) {
                        setDialogState(() => selectedAvatar = path);
                      }
                    } catch (_) {
                      if (!dialogContext.mounted) return;
                      ScaffoldMessenger.of(dialogContext).showSnackBar(
                        const SnackBar(content: Text('Foto belum bisa dipilih. Coba lagi.')),
                      );
                    }
                  },
                  child: CircleAvatar(
                    radius: 42,
                    backgroundColor: _profilePurple.withOpacity(.2),
                    backgroundImage: selectedAvatar != null && File(selectedAvatar!).existsSync()
                        ? FileImage(File(selectedAvatar!))
                        : null,
                    child: selectedAvatar == null
                        ? const Icon(Icons.add_a_photo_outlined, color: Colors.white, size: 28)
                        : null,
                  ),
                ),
                const SizedBox(height: 8),
                const Text('Ketuk foto untuk mengganti', style: TextStyle(color: _profileMuted, fontSize: 11)),

              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: const Text('Batal'),
              ),
              FilledButton(
                onPressed: () => Navigator.of(dialogContext).pop(selectedAvatar),
                child: const Text('Simpan'),
              ),
            ],
          ),
        ),
      );
    } finally {
    }

    // Persist and rebuild only after the dialog route has fully closed.
    if (result == null || !mounted) return;
    await _settings.put('skyfyProfileAvatar', result);
    if (!mounted) return;
    setState(() => _avatarPath = result);
  }

  Widget _group(List<Widget> children) => Container(
        decoration: BoxDecoration(
          color: _profileSurface.withOpacity(.94),
          borderRadius: BorderRadius.circular(19),
          border: Border.all(color: Colors.white.withOpacity(.045)),
        ),
        child: Column(children: [
          for (var i = 0; i < children.length; i++) ...[
            children[i],
            if (i != children.length - 1)
              Divider(height: 1, indent: 56, color: Colors.white.withOpacity(.055)),
          ],
        ]),
      );

  Widget _item(IconData icon, String title, String subtitle, VoidCallback action) =>
      Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: action,
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
            child: Row(children: [
              Container(
                width: 36, height: 36,
                decoration: BoxDecoration(
                  color: _profilePurple.withOpacity(.13),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Icon(icon, color: _profilePurple, size: 19),
              ),
              const SizedBox(width: 12),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(
                    color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700,
                  )),
                  const SizedBox(height: 3),
                  Text(subtitle, style: const TextStyle(color: _profileMuted, fontSize: 10)),
                ],
              )),
              const Icon(Icons.chevron_right_rounded, color: _profileMuted, size: 20),
            ]),
          ),
        ),
      );

  Widget _iconButton(IconData icon, VoidCallback action) => InkWell(
        onTap: action,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          width: 38, height: 38,
          decoration: const BoxDecoration(color: _profileSurface, shape: BoxShape.circle),
          child: Icon(icon, color: Colors.white, size: 19),
        ),
      );
}

