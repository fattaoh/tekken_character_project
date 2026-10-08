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
      onTap: () => detailPage(tekken),
      leading: ClipRRect(
        borderRadius: BorderRadius.horizontal(),
        child: Hero(
            tag: 'tekken-image',
            child: Image.asset(
              tekken.image,
              width: 56,
              height: 56,
              fit: BoxFit.fitHeight,
            ),
        ),
      ),
      title: Text(tekken.name),
      subtitle: Difficulty(difficulty: tekken.difficulty, label: Text(tekken.difficulty),),
      trailing: Icon(Icons.favorite_border),
    );
  }
}
