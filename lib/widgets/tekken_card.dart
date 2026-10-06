import 'package:flutter/material.dart';
import 'package:tekken_project/models/tekken.dart';
import 'package:tekken_project/pages/detail_pages.dart';

class TekkenCard extends StatelessWidget {
  final Tekken tekken;
  const TekkenCard({super.key, required this.tekken});

  @override
  Widget build(BuildContext context) {

    // function
  void detailPage(Tekken tekken){
    Navigator.push(context, MaterialPageRoute(builder: (_) => DetailPage(tekken: tekken)));
  }



    return InkWell(
      onTap: (){
        detailPage(tekken);
      },
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Hero(
              tag: 'tekken.name',
              child: Image.asset(
                  'assets/tekken.image',
                   fit: BoxFit.cover,
                   width: double.infinity,
                   height: 75,
              ),
            ),
            SizedBox(height: 20),
            
          ]
        )
      ),
    );
  }
}
