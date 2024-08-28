import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lodione/models/user_model.dart';

final usersProvider = StreamProvider<List<UserModel>>((ref) {
  return FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .map((snapshot) {
    return snapshot.docs.map((doc) => UserModel.fromFirestore(doc)).toList();
  });
});

class UsersList extends ConsumerWidget {
  const UsersList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(usersProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Users List')),
      body: ListView.builder(
        itemCount: users.value?.length ?? 0,
        itemBuilder: (context, index) {
          final user = users.value![index];
          return Card(
            child: ListTile(
              title: Text(user.name),
              subtitle: Text(user.email),
            ),
          );
        },
      ),
    );
  }
}
