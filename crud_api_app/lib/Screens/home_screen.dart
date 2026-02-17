import 'package:crud_api_app/Models/post_model.dart';
import 'package:crud_api_app/Screens/post_form_Screen.dart';
import 'package:crud_api_app/Services/api_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  void confirmDelete(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete?'),
        content: const Text('Are you sure?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () async {
              await ApiService().deleteRequest(id);
              Navigator.pop(context);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Post deleted')));
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('All posts')),

      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<UserModel>>(
                future: ApiService().fetchData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  final posts = snapshot.data!;
                  return ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ListTile(
                          onLongPress: () {
                            confirmDelete(context, index);
                          },
                          shape: OutlineInputBorder(
                            borderRadius: .circular(20),
                          ),
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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PostFormScreen()),
          );
        },
        child: Text('P o s t'),
      ),
    );
  }
}
