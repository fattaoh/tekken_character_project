import 'package:flutter/material.dart';

class Difficulty extends StatelessWidget {
  final String difficulty;
  final Widget? label;

  const Difficulty({super.key, required this.difficulty, this.label});

  Color _difficultyColor() {
    if (difficulty.contains('Easy')) return Colors.blue;
    if (difficulty.contains('Normal')) return Colors.lightGreen;
    if (difficulty.contains('Very Hard')) return Colors.red;
    if (difficulty.contains('Hard')) return Colors.orange;
    return Colors.amber;
  }

  @override
  Widget build(BuildContext context) {
    final color = _difficultyColor();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.48)),
      ),
      child:
          label ??
          Text(
            difficulty,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
    );
  }
}
