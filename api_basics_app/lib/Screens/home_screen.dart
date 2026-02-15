import 'package:api_basics_app/Services/post_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('A P I  D a t a')),
      body: SafeArea(
        child: FutureBuilder(
          future: PostService().fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.error != null) {
              return Center(child: Text('Error : ${snapshot.error}'));
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('Post not Found'));
            }
            final posts = snapshot.data!;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListTile(
                    shape: OutlineInputBorder(borderRadius: .circular(20)),
                    tileColor: Colors.black12,
                    leading: Text(
                      post.id.toString(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        post.title.toString(),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        post.body.toString(),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
