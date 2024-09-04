// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// import '../models/item_model.dart';
// import '../models/list_model.dart';

// class ListProvider with ChangeNotifier {
//   List<ListModel> _lists = [];
//   ListModel? _selectedList;

//   List<ListModel> get lists => _lists;
//   ListModel? get selectedList => _selectedList;

//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth auth = FirebaseAuth.instance;
//   final String userID = FirebaseAuth.instance.currentUser!.uid;
//   final listCollection = FirebaseFirestore.instance
//       .collection('users')
//       .doc(FirebaseAuth.instance.currentUser!.uid)
//       .collection('lists');

//   ListProvider() {
//     _initList();
//   }

//   void _initList() {
//     listCollection.snapshots().listen((snapshot) {
//       _lists = snapshot.docs
//           .map((doc) => ListModel.fromFirestore(doc.data()))
//           .toList();
//       notifyListeners();
//     });
//   }

//   void selectList(ListModel? list) {
//     _selectedList = list;
//     if (_selectedList != null) {
//       // _fetchItemsForSelectedList();
//       print('Selected list: ${_selectedList!.name}');
//     } else {
//       // Optionally clear items if no list is selected
//       _selectedList?.items = [];
//     }
//     notifyListeners();
//   }

//   void _fetchItemsForSelectedList() async {
//     if (_selectedList == null) return;

//     try {
//       final itemsSnapshot = await FirebaseFirestore.instance
//           .collection('lists')
//           .doc(_selectedList!.id)
//           .collection('items')
//           .get();

//       _selectedList!.items = itemsSnapshot.docs
//           .map((doc) => ItemModel.fromJson(doc.data()))
//           .toList();

//       notifyListeners();
//     } catch (e) {
//       // Handle error, perhaps show a snackbar or log the error
//       print('Failed to fetch items: $e');
//       // Optionally set items to an empty list or show an error state
//       _selectedList!.items = [];
//       notifyListeners();
//     }
//   }

//   //   void _loadSharedList() {
//   //     // This should be dynamically set or passed
//   //   _firestore.collection('lists').where('sharedWith', arrayContains: _userID).snapshots().listen((snapshot) {
//   //     _lists = snapshot.docs.map((doc) => ListModel.fromFirestore(doc.data())).toList();
//   //     notifyListeners();
//   //   });
//   // }

//   Future<void> addList(ListModel newList) async {
//     try {
//       final listRef = await listCollection.add(newList.toFirestore());
//       newList.id = listRef.id;
//       _lists.add(newList);
//       notifyListeners();
//     } catch (e) {
//       print(e);
//       return;
//     }
//     _initList();
//   }

//   Future<void> removeList(String id) async {
//     await listCollection.doc(id).delete();
//     _lists.removeWhere((list) => list.id == id);
//     notifyListeners();
//   }

//   Future<void> addItemToList(String listID, ItemModel item) async {
//     await _firestore.collection('lists').doc(listID).update({
//       'items': FieldValue.arrayUnion([item.toFirestore()])
//     });
//     // Assuming you update the local list here for UI responsiveness
//     final listIndex = _lists.indexWhere((list) => list.id == listID);
//     if (listIndex != -1) {
//       _lists[listIndex].items.add(item);
//       notifyListeners();
//     }
//   }

//   Future<void> removeItemFromList(String listID, String itemID) async {
//     await _firestore.collection('lists').doc(listID).update({
//       'items': FieldValue.arrayRemove([itemID])
//     });
//     // Assuming you update the local list here for UI responsiveness
//     final listIndex = _lists.indexWhere((list) => list.id == listID);
//     if (listIndex != -1) {
//       _lists[listIndex].items.removeWhere((item) => item.id == itemID);
//       notifyListeners();
//     }
//   }

//   // Implement other methods like updateItemInList, moveItemsToOtherList, etc.,
//   // remembering to call notifyListeners() after any change to the state.

//   // Example for updating an item:
//   Future<void> updateItemInList(String listID, ItemModel newItem) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection('lists')
//           .doc(listID)
//           .collection('items')
//           .doc(newItem.id)
//           .update(newItem.toFirestore());

//       final listIndex = _lists.indexWhere((list) => list.id == listID);
//       if (listIndex != -1) {
//         int itemIndex =
//             _lists[listIndex].items.indexWhere((item) => item.id == newItem.id);
//         if (itemIndex != -1) {
//           _lists[listIndex].items[itemIndex] = newItem;
//           notifyListeners();
//           // Here you would also update Firestore
//         }
//       }
//     } catch (e) {
//       return;
//     }
//   }
// }
