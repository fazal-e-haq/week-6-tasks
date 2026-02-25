import 'package:flutter/material.dart';
import 'package:image_upload_app/Provider/image_upload_provider.dart';
import 'package:image_upload_app/Screen/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ImageUploadProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: .dark(),
      themeMode: .dark,
      home: HomeScreen(),
    );
  }
}
