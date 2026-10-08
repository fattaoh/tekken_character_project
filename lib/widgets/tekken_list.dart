import 'package:flutter/material.dart';
import 'package:tekken_project/pages/detail_pages.dart';
import 'package:tekken_project/models/tekken.dart';

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
        borderRadius: BorderRadius.circular(999),
        child: Hero(
            tag: 'tekken-image',
            child: Image.asset(
              tekken.image,
              width: 56,
              height: 56,
              fit: BoxFit.cover,
            ),
        ),
      ),
      title: Text(tekken.name),
      subtitle: Text(tekken.type),
      trailing: Icon(Icons.favorite_border),
    );
  }
}
