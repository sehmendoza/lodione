import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/new_user_provider.dart';

class UsersList extends ConsumerWidget {
  const UsersList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(userProvider);
    print('printed users list');
    print(users);
    return Scaffold(
      appBar: AppBar(title: const Text('Users List')),
      body: ListView.builder(
        itemCount: users.users.length,
        itemBuilder: (context, index) {
          final user = users.users[index];
          return Card(
            child: ListTile(
              title: Text(user.name),
              subtitle: Text(user.username),
            ),
          );
        },
      ),
    );
  }
}
