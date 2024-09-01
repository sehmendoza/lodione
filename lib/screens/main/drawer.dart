// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:lodione/providers/user_provider.dart';

// class MyDrawer extends ConsumerStatefulWidget {
//   const MyDrawer({super.key, required this.onTap});

//   final void Function() onTap;

//   @override
//   ConsumerState<MyDrawer> createState() => _MyDrawerState();
// }

// class _MyDrawerState extends ConsumerState<MyDrawer> {
//   @override
//   Widget build(BuildContext context) {
//     final userData = ref.watch(userProvider);
//     return Drawer(
//       backgroundColor: Colors.black,
//       child: Consumer(builder: (context, ref, child) {
//         return ListView(
//           children: [
//             DrawerHeader(
//               decoration: const BoxDecoration(color: Colors.black),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Image.asset(
//                     'lib/images/lodione_logo_side.png',
//                     height: 60,
//                   ),
//                   const Spacer(),
//                   ListTile(
//                     title: Text(
//                       userData!.name,
//                       style: const TextStyle(
//                         overflow: TextOverflow.ellipsis,
//                         letterSpacing: 1.5,
//                         color: Colors.white,
//                         fontSize: 20,
//                       ),
//                     ),
//                     subtitle: Text(
//                       userData.username,
//                       style: const TextStyle(
//                         letterSpacing: 1.2,
//                         color: Colors.white60,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                     onTap: widget.onTap,
//                   ),
//                 ],
//               ),
//             ),
//             ExpansionTile(
//                 leading:
//                     const Icon(Icons.person_add_alt_1, color: Colors.white),
//                 title: Row(
//                   children: [
//                     const Text('Friend Requests',
//                         style: TextStyle(color: Colors.white70)),
//                     Container(
//                       margin: const EdgeInsets.only(left: 6),
//                       padding: const EdgeInsets.all(7.5),
//                       decoration: const BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Colors.white,
//                       ),
//                       child: const Text(
//                         '1',
//                         // ref
//                         //     .watch(listProvider)
//                         //     .firstWhere((list) => list.id == listModel.id)
//                         //     .items
//                         //     .length
//                         //     .toString(),
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 16,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 children: [
//                   ListTile(
//                     title: const Text(
//                       'Recyline',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                     subtitle: const Text('@recypoli',
//                         style: TextStyle(color: Colors.white60)),
//                     trailing: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         IconButton(
//                           onPressed: () {},
//                           icon: const Icon(Icons.close, color: Colors.red),
//                         ),
//                         const SizedBox(width: 10),
//                         IconButton(
//                           onPressed: () {},
//                           icon: const Icon(Icons.check, color: Colors.white),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ]),
//           ],
//         );
//       }),
//     );
//   }
// }
