import 'package:flutter/material.dart';
import 'package:lodione/const.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const Text(
                //   'Grocery List',
                //   style: TextStyle(
                //       color: black,
                //       fontSize: 18,
                //       fontWeight: FontWeight.bold,
                //       letterSpacing: 1,
                //       decoration: TextDecoration.none,
                //       fontFamily: 'Poppins',
                //       fontStyle: FontStyle.normal),
                // ),
                // const Text('by: John Doe'),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  title: const Text(
                    'Grocery List',
                    style: TextStyle(
                        color: black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        decoration: TextDecoration.none,
                        fontFamily: 'Poppins',
                        fontStyle: FontStyle.normal),
                  ),
                  subtitle: const Text('by: John Doe'),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.settings),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Center(child: Text('0/5 completed')),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Add List'),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 8, top: 8),
            child: Text(
              'Select a list',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                  letterSpacing: 1),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      title: const Text('Grocery List'),
                      subtitle: const Text('by: John Doe'),
                      trailing: const Text('0/5 completed'),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
