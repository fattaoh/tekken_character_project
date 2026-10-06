import 'package:flutter/material.dart';
import 'package:tekken_project/data/tekken_data.dart';
import 'package:tekken_project/widgets/tekken_list.dart';
import 'package:tekken_project/models/tekken.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final List<Tekken> tekken = dataTekken;

  


  // final TextField _searchController = TextField();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tekken 8'),
        centerTitle: true,
        leading: Icon(Icons.arrow_back_outlined),
        actions: [
          Icon(Icons.favorite),
          SizedBox(width: 10),
        ],

      ),
      body: ListView.builder(
        itemCount: tekken.length,  
        itemBuilder: (BuildContext context, int index){
          return TekkenList(tekken: tekken[index]);
        },
      ),
    );
  }
}
