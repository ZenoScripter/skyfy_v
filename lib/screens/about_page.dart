/*
 * SKYFY developer and application information.
 * Original Musify project attribution and license remain in the repository.
 */
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:material_ui/material_ui.dart';
import 'package:musify/utilities/url_launcher.dart';
import 'package:musify/widgets/mini_player_bottom_space.dart';

const _skyfyBg = Color(0xFF080610);
const _skyfyCard = Color(0xFF171126);
const _skyfyPurple = Color(0xFFA778FF);
const _skyfyMuted = Color(0xFFAAA1BC);

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  Future<void> _open(BuildContext context, Uri uri) async {
    try {
      await launchURL(uri);
    } catch (_) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tautan tidak dapat dibuka saat ini.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _skyfyBg,
      appBar: AppBar(
        title: const Text('Informasi & Developer'),
        backgroundColor: _skyfyBg,
        foregroundColor: Colors.white,
      ),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/skyfy_background.jpg'),
            fit: BoxFit.cover,
            opacity: .13,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 16, 18, 24),
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    width: 82,
                    height: 82,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [_skyfyPurple, Color(0xFF43216F)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: _skyfyPurple.withOpacity(.25),
                          blurRadius: 24,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: const Icon(
                      FluentIcons.music_note_2_24_filled,
                      color: Colors.white,
                      size: 42,
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'SKYFY',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2.2,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Music for your moment',
                    style: TextStyle(color: _skyfyMuted, fontSize: 13),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            _sectionTitle('TENTANG SKYFY'),
            _panel(
              child: const Text(
                'SKYFY adalah aplikasi pemutar musik yang dibuat untuk menikmati, '
                'mencari, mengatur, dan menyimpan musik dalam satu tempat. '
                'Project ini dikembangkan dengan Flutter dan membawa fitur '
                'pemutaran musik, playlist, koleksi lagu, lirik, serta mode offline.',
                style: TextStyle(color: Colors.white, height: 1.6, fontSize: 13),
              ),
            ),
            const SizedBox(height: 22),
            _sectionTitle('VERSI APLIKASI'),
            _panel(
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _InfoRow(label: 'Nama aplikasi', value: 'SKYFY'),
                  SizedBox(height: 10),
                  _InfoRow(label: 'Versi', value: '10.6.0'),
                  SizedBox(height: 10),
                  _InfoRow(label: 'Build', value: '186'),
                  SizedBox(height: 10),
                  _InfoRow(label: 'Platform', value: 'Flutter • Android'),
                ],
              ),
            ),
            const SizedBox(height: 22),
            _sectionTitle('DEVELOPER'),
            _panel(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _skyfyPurple.withOpacity(.18),
                          border: Border.all(color: _skyfyPurple.withOpacity(.5)),
                        ),
                        child: const Icon(
                          FluentIcons.person_24_filled,
                          color: _skyfyPurple,
                          size: 25,
                        ),
                      ),
                      const SizedBox(width: 13),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Wildan', style: TextStyle(
                              color: Colors.white, fontSize: 17,
                              fontWeight: FontWeight.w800,
                            )),
                            SizedBox(height: 3),
                            Text('Creator & Developer of SKYFY', style: TextStyle(
                              color: _skyfyMuted, fontSize: 11,
                            )),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 17),
                  const Text(
                    'Merancang dan mengembangkan SKYFY sebagai project aplikasi '
                    'musik, mulai dari tampilan, pengalaman pengguna, hingga '
                    'integrasi fitur pemutar musik.',
                    style: TextStyle(color: Colors.white, height: 1.55, fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            _sectionTitle('TEMUKAN AKU'),
            _panel(
              child: Column(
                children: [
                  _contactRow(
                    Icons.music_note_rounded,
                    'TikTok',
                    '@nexsyncc',
                    () => _open(context, Uri.parse('https://www.tiktok.com/@nexsyncc')),
                  ),
                  _divider(),
                  _contactRow(
                    Icons.camera_alt_outlined,
                    'Instagram',
                    '@nexsyncc',
                    () => _open(context, Uri.parse('https://www.instagram.com/nexsyncc/')),
                  ),
                  _divider(),
                  _contactRow(
                    Icons.mail_outline_rounded,
                    'Email',
                    'wilgtwilgt@gmail.com',
                    () => _open(context, Uri.parse('mailto:wilgtwilgt@gmail.com')),
                  ),
                  _divider(),
                  _contactRow(
                    Icons.code_rounded,
                    'GitHub Project',
                    'ZenoScripter / skyfxv4',
                    () => _open(context, Uri.parse('https://github.com/ZenoScripter/skyfxv4')),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            _sectionTitle('DIBANGUN DENGAN'),
            _panel(
              child: const Row(
                children: [
                  _TechChip(label: 'Flutter'),
                  SizedBox(width: 8),
                  _TechChip(label: 'Dart'),
                  SizedBox(width: 8),
                  _TechChip(label: 'Android'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Center(
              child: Text(
                'Made with care by Wildan',
                style: TextStyle(color: _skyfyMuted, fontSize: 10, letterSpacing: .5),
              ),
            ),
            const MiniPlayerBottomSpace(),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) => Padding(
        padding: const EdgeInsets.only(left: 3, bottom: 9),
        child: Text(title, style: const TextStyle(
          color: _skyfyPurple, fontSize: 10, fontWeight: FontWeight.w800,
          letterSpacing: 1.4,
        )),
      );

  Widget _panel({required Widget child}) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _skyfyCard.withOpacity(.94),
          borderRadius: BorderRadius.circular(19),
          border: Border.all(color: Colors.white.withOpacity(.06)),
        ),
        child: child,
      );

  Widget _divider() => Divider(height: 1, color: Colors.white.withOpacity(.06));

  Widget _contactRow(
    IconData icon,
    String label,
    String value,
    VoidCallback onTap,
  ) => InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              Icon(icon, color: _skyfyPurple, size: 21),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label, style: const TextStyle(
                      color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700,
                    )),
                    const SizedBox(height: 3),
                    Text(value, style: const TextStyle(color: _skyfyMuted, fontSize: 11)),
                  ],
                ),
              ),
              const Icon(Icons.open_in_new_rounded, color: _skyfyMuted, size: 16),
            ],
          ),
        ),
      );
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(child: Text(label, style: const TextStyle(color: _skyfyMuted, fontSize: 12))),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
        ],
      );
}

class _TechChip extends StatelessWidget {
  const _TechChip({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
        decoration: BoxDecoration(
          color: _skyfyPurple.withOpacity(.12),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: _skyfyPurple.withOpacity(.25)),
        ),
        child: Text(label, style: const TextStyle(
          color: Color(0xFFD8C4FF), fontSize: 10, fontWeight: FontWeight.w700,
        )),
      );
}
