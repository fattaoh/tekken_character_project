import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Difficulty extends StatelessWidget {
  final String difficulty;
  final Widget label;

  const Difficulty({super.key, required this.difficulty, required this.label});

  Color _difficultyColor(){
    if(difficulty.contains('Easy')) return Colors.blue;
    if(difficulty.contains('Normal')) return Colors.lightGreen;
    if(difficulty.contains('Hard')) return Colors.orange;
    if(difficulty.contains('Very Hard')) return Colors.red;
    return Colors.amber;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _difficultyColor().withOpacity(0.15),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.amber, width: 1),
      ),
      child: Text(difficulty),
    );
  }
}
