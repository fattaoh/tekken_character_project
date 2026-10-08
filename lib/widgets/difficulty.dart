import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Difficulty extends StatelessWidget {
  final String difficulty;
  final Widget? label;

  const Difficulty({
    super.key,
    required this.difficulty,
    this.label,
  });

  Color _difficultyColor() {
    if (difficulty.contains('Easy')) return Colors.blue;
    if (difficulty.contains('Normal')) return Colors.lightGreen;
    if (difficulty.contains('Hard')) return Colors.orange;
    if (difficulty.contains('Very Hard')) return Colors.red;
    return Colors.amber;
  }

  @override
  Widget build(BuildContext context) {
    final color = _difficultyColor();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color, width: 1.5),
      ),
      child: label ?? Text(difficulty),
    );
  }
}
