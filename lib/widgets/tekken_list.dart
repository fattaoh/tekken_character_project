import 'package:flutter/material.dart';
import 'package:tekken_project/pages/detail_pages.dart';
import 'package:tekken_project/models/tekken.dart';
import 'package:tekken_project/widgets/difficulty.dart';

class TekkenList extends StatelessWidget {
  final Tekken tekken;
  const TekkenList({super.key, required this.tekken});

  @override
  Widget build(BuildContext context) {

    void detailPage(Tekken tekken){
      Navigator.push(context, 
      MaterialPageRoute(builder: (_) => DetailPage(tekken: tekken)));
    }

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      onTap: () => detailPage(tekken),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Hero(
          tag: 'tekken-image-${tekken.name}',
          child: Image.asset(
            tekken.image,
            width: 66,
            height: 66,
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
      title: Text(
        tekken.name,
        style: const TextStyle(fontWeight: FontWeight.w700),
      ),
      subtitle: Difficulty(
        difficulty: tekken.difficulty,
        label: Text(tekken.difficulty),
      ),
      trailing: const Icon(Icons.favorite_border, size: 20),
    );
  }
}
