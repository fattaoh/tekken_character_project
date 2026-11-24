import 'package:flutter/material.dart';
import 'package:tekken_project/data/skill_controls.dart';
import 'package:tekken_project/models/tekken.dart';
import 'package:tekken_project/widgets/difficulty.dart';

void _noFavoriteToggle() {}

class DetailPage extends StatefulWidget {
  final Tekken tekken;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const DetailPage({
    super.key,
    required this.tekken,
    this.isFavorite = false,
    this.onFavoriteToggle = _noFavoriteToggle,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
  }

  void _toggleFavorite() {
    widget.onFavoriteToggle();
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final tekken = widget.tekken;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil petarung'),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: _isFavorite ? 'Hapus dari favorit' : 'Tambah ke favorit',
            onPressed: _toggleFavorite,
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: _isFavorite ? colors.primary : null,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(26),
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Hero(
                    tag: 'tekken-image-${tekken.name}',
                    child: Image.asset(
                      tekken.image,
                      width: double.infinity,
                      height: 330,
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                  Container(
                    height: 175,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.88),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          tekken.name.toUpperCase(),
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.4,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: colors.primary,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            tekken.type,
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: colors.onPrimary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: colors.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Tingkat kesulitan',
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Difficulty(difficulty: tekken.difficulty),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Base power',
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Text(
                        '${tekken.basePower}',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: colors.primary,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: (tekken.basePower / 100).clamp(0.0, 1.0),
                      minHeight: 8,
                      backgroundColor: colors.surface,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 26),
            _SectionTitle(title: 'Tentang karakter'),
            const SizedBox(height: 10),
            Text(
              tekken.description,
              style: theme.textTheme.bodyLarge?.copyWith(
                height: 1.65,
                color: colors.onSurface.withValues(alpha: 0.82),
              ),
            ),
            const SizedBox(height: 26),
            _SectionTitle(title: 'Signature moves'),
            const SizedBox(height: 12),
            ...tekken.skills.asMap().entries.map(
              (entry) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Material(
                  color: colors.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(16),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () => _showSkillGuide(
                      context,
                      characterName: tekken.name,
                      skillName: entry.value,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 13,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: colors.primary.withValues(alpha: 0.16),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              '${entry.key + 1}'.padLeft(2, '0'),
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: colors.primary,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              entry.value,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.touch_app_outlined,
                            size: 18,
                            color: colors.onSurfaceVariant,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _showSkillGuide(
  BuildContext context, {
  required String characterName,
  required String skillName,
}) {
  final guide = skillControlGuides[characterName]?[skillName];
  final steps = guide == null
      ? <String>[]
      : buildControllerSteps(guide.notation);

  showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(skillName),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (guide == null)
              Text(
                'Urutan tombol untuk $skillName belum tersedia di aplikasi. '
                'Buka Pause > Command List di Tekken 8 lalu pilih move ini '
                'untuk melihat input yang tepat.',
              )
            else ...[
              Text('Input: ${guide.notation}'),
              if (guide.prerequisite != null) ...[
                const SizedBox(height: 8),
                Text(guide.prerequisite!),
              ],
              const SizedBox(height: 16),
              Text(
                'Langkah menekan tombol',
                style: Theme.of(context).textTheme.titleSmall
                    ?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 6),
              ...steps.asMap().entries.map(
                (entry) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text('${entry.key + 1}. ${entry.value}'),
                ),
              ),
            ],
            const SizedBox(height: 18),
            Text(
              'Notasi tombol controller',
              style: Theme.of(context).textTheme.titleSmall
                  ?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            const Text(
              '1 = □ (PlayStation) / X (Xbox)\n'
              '2 = △ (PlayStation) / Y (Xbox)\n'
              '3 = × (PlayStation) / A (Xbox)\n'
              '4 = ○ (PlayStation) / B (Xbox)',
            ),
            const SizedBox(height: 12),
            Text(
              'f = depan (arah lawan), b = belakang, d = bawah, u = atas. '
              'Tanda + berarti tombol ditekan bersamaan; koma berarti input '
              'dilakukan berurutan. Arah depan dan belakang berubah mengikuti '
              'posisi karakter.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Mengerti'),
        ),
      ],
    ),
  );
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge
          ?.copyWith(fontWeight: FontWeight.w800),
    );
  }
}
