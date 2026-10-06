import 'package:flutter/material.dart';
import 'package:flutter_apps/models/pokemon.dart';
import 'package:flutter_apps/pages/detail_page.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;
  const PokemonCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {

    // function
  void detailPage(Pokemon pokemon){
    Navigator.push(context, MaterialPageRoute(builder: (_) => DetailPage(pokemon: pokemon)));
  }



    return InkWell(
      onTap: (){
        detailPage(pokemon);
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
              tag: 'pokemon.name',
              child: Image.asset(
                  'assets/pokemon.image',
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
