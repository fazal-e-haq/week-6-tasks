import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<UserProvider>();

      controller.addListener(() {
        if (controller.position.pixels == controller.position.maxScrollExtent &&
            provider.hasMore) {
          provider.fetchUsers();
        }
      });

      provider.fetchUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('U s e r s'),
        bottom: PreferredSize(
          preferredSize: .fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: context.read<UserProvider>().searching,
              decoration: InputDecoration(hintText: 'Search', filled: true),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Consumer<UserProvider>(
          builder: (_, provider, __) {
            if (provider.isloading && provider.isloading) {
              return Center(child: CircularProgressIndicator());
            }
            if (context.read<UserProvider>().error != null) {
              return Center(child: Text(provider.error!));
            }

            return RefreshIndicator(
              onRefresh: () => provider.fetchUsers(refresh: true),
              child: ListView.builder(
                controller: controller,
                itemCount: provider.filter.length + (provider.hasMore ? 1 : 0),
                itemBuilder: (_, i) {
                  if (i == provider.filter.length) {
                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  final user = provider.filter[i];
                  return ListTile(
                    title: Text(user.name),
                    subtitle: Text(user.email),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
