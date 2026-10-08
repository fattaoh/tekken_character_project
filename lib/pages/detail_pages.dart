import 'package:flutter/material.dart';
import 'package:tekken_project/models/tekken.dart';
import 'package:tekken_project/widgets/difficulty.dart';

class DetailPage extends StatelessWidget {
  final Tekken tekken;

  const DetailPage({super.key, required this.tekken});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tekken.name),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                tekken.image,
                width: double.infinity,
                height: 280,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              tekken.name,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Chip(label: Text(tekken.type)),
            const SizedBox(height: 16),
            Difficulty(
              difficulty: tekken.difficulty,
            ),
            const SizedBox(height: 16,),
            Text(
              'Deskripsi',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              tekken.description,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 16),
            Text(
              'Skills',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            ...tekken.skills.map(
              (skill) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    const Icon(Icons.star, size: 18),
                    const SizedBox(width: 8),
                    Expanded(child: Text(skill)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
