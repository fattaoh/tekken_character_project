import 'package:flutter/material.dart';
import 'package:tekken_project/data/tekken_data.dart';
import 'package:tekken_project/models/tekken.dart';
import 'package:tekken_project/widgets/tekken_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Set<String> _favoriteNames = {};

  List<Tekken> get tekken => dataTekken;

  void _toggleFavorite(Tekken character) {
    setState(() {
      if (_favoriteNames.contains(character.name)) {
        _favoriteNames.remove(character.name);
      } else {
        _favoriteNames.add(character.name);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 20,
        title: const Row(
          children: [
            Icon(Icons.sports_martial_arts, size: 23),
            SizedBox(width: 10),
            Text('TEKKEN 8'),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Favorit',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => _FavoritesPage(
                    favorites: dataTekken
                        .where(
                          (character) =>
                              _favoriteNames.contains(character.name),
                        )
                        .toList(),
                    favoriteNames: _favoriteNames,
                    onToggleFavorite: _toggleFavorite,
                  ),
                ),
              );
            },
            icon: Icon(
              _favoriteNames.isEmpty ? Icons.favorite_border : Icons.favorite,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(26),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  colors.primary,
                  colors.primary.withValues(alpha: 0.72),
                  const Color(0xFF252A38),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 11,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.13),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    'THE KING OF IRON FIST',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: Colors.white,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  'Pilih petarungmu',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Kenali gaya bertarung dan kemampuan setiap karakter.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.78),
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Icon(
                      Icons.people_alt_outlined,
                      color: Color(0xFFFFB45C),
                      size: 19,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${tekken.length} petarung tersedia',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Daftar petarung',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Text(
                'TEKKEN 8',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: colors.primary,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ...tekken.map(
            (character) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: TekkenList(
                tekken: character,
                isFavorite: _favoriteNames.contains(character.name),
                onFavoriteToggle: () => _toggleFavorite(character),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FavoritesPage extends StatefulWidget {
  final List<Tekken> favorites;
  final Set<String> favoriteNames;
  final ValueChanged<Tekken> onToggleFavorite;

  const _FavoritesPage({
    required this.favorites,
    required this.favoriteNames,
    required this.onToggleFavorite,
  });

  @override
  State<_FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<_FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    final favorites = dataTekken
        .where((character) => widget.favoriteNames.contains(character.name))
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Favorit'), centerTitle: true),
      body: favorites.isEmpty
          ? const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.favorite_border, size: 56),
                  SizedBox(height: 12),
                  Text('Belum ada karakter favorit'),
                ],
              ),
            )
          : ListView(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
              children: favorites
                  .map(
                    (character) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: TekkenList(
                        tekken: character,
                        isFavorite: true,
                        onFavoriteToggle: () {
                          widget.onToggleFavorite(character);
                          setState(() {});
                        },
                      ),
                    ),
                  )
                  .toList(),
            ),
    );
  }
}
