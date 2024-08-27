import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lodione/providers/user_provider.dart';

class MyDrawer extends ConsumerStatefulWidget {
  const MyDrawer({super.key, required this.onTap});

  final void Function() onTap;

  @override
  ConsumerState<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends ConsumerState<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    final userData = ref.watch(userDataProvider);

    return Drawer(
      backgroundColor: Colors.black,
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.black),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'lib/images/lodione_logo_side.png',
                  height: 60,
                ),
                const Spacer(),
                ListTile(
                  title: Text(
                    userData['name'] ?? 'No Name',
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      letterSpacing: 1.5,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  subtitle: Text(
                    '@${userData['username'] ?? 'No Username'}',
                    style: const TextStyle(
                      letterSpacing: 1.2,
                      color: Colors.white60,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  onTap: widget.onTap,
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: 99,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(Icons.notifications),
                title: Text('Notification ${index + 1}'),
                subtitle: const Text('This is a sample notification'),
                onTap: () {
                  // Handle notification tap
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
