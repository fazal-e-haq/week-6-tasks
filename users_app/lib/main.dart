import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:users_app/Screens/home_screens.dart';
import 'package:users_app/providers/user_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (context) => UserProvider(), child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: .dark(),
      themeMode: .dark,
      home:   HomeScreen(),
    );
  }
}
