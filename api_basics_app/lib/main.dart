import 'package:api_basics_app/Screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
        darkTheme: .dark(),
        themeMode: .dark, home: HomeScreen());
  }
}
