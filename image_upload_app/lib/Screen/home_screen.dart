import 'package:flutter/material.dart';
import 'package:image_upload_app/Provider/image_upload_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ImageUploadProvider>();

    return Scaffold(
      appBar: AppBar(title: Text('H E L L O')),
      body: SafeArea(
        child: Padding(
          padding: .symmetric(horizontal: 16),
          child: Center(
            child: Column(
              children: [
                if (provider.imageFile != null)
                  Image.file(provider.imageFile!, height: 150),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: provider.pickImage,
                  child: Text('Pick Image'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: provider.uploadImage,
                  child: Text('Upload Image'),
                ),
                SizedBox(height: 20),
                if (provider.imageUrl != null)
                  Image.network(provider.imageUrl!, height: 150),
                if (provider.error != null) Text(provider.error!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
