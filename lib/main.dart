import 'package:flutter/material.dart';
import 'package:tekken_project/pages/home_pages.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tekken 8',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF7A1A),
          brightness: Brightness.dark,
          surface: const Color(0xFF171A22),
        ),
        scaffoldBackgroundColor: const Color(0xFF101218),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF101218),
          foregroundColor: Color(0xFFF4F4F5),
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Color(0xFFF4F4F5),
            fontSize: 16,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.1,
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFFF4F4F5)),
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
      routes: {'/home-page': (context) => const HomePage()},
    );
  }
}
