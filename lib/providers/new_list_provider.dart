import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lodione/providers/firebase.dart';

import '../models/list_model.dart';
import 'user_provider.dart';

final listsProvider = StreamProvider<List<ListModel>>((ref) {
  final firestore = ref.watch(firestoreProvider);
  final user = ref.read(userProvider.notifier).uid;
  return firestore
      .collection('users')
      .doc(user)
      .collection('lists')
      .snapshots()
      .map((snapshot) {
    return snapshot.docs.map((doc) => ListModel.fromJson(doc.data())).toList();
  });
});

final selectedListProvider = StateProvider<ListModel?>((ref) => null);

class ListsNotifier extends StateNotifier<List<ListModel>> {
  ListsNotifier(this.ref) : super([]) {
    _initialize();
  }

  final Ref ref;

  Future<void> _initialize() async {
    final lists = await _fetchLists();
    state = lists;
  }

  Future<List<ListModel>> _fetchLists() async {
    final user = ref.read(userProvider.notifier).uid;
    final snapshot = await ref
        .read(firestoreProvider)
        .collection('users')
        .doc(user)
        .collection('lists')
        .get();
    return snapshot.docs.map((doc) => ListModel.fromJson(doc.data())).toList();
  }

  void addTodo(ListModel list) {
    ref
        .read(firestoreProvider)
        .collection('users')
        .doc(ref.read(userProvider.notifier).uid)
        .collection('lists')
        .add(list.toFirestore());
    state = [...state, list];
  }

  void updateTodo(ListModel list) {
    ref
        .read(firestoreProvider)
        .collection('users')
        .doc(ref.read(userProvider.notifier).uid)
        .collection('lists')
        .doc(list.id)
        .update(list.toFirestore());
    state = state.map((t) => t.id == list.id ? list : t).toList();
  }

  void deleteTodo(String id) {
    ref
        .read(firestoreProvider)
        .collection('users')
        .doc(ref.read(userProvider.notifier).uid)
        .collection('lists')
        .doc(id)
        .delete();
    state = state.where((list) => list.id != id).toList();
  }
}

final listsNotifierProvider =
    StateNotifierProvider<ListsNotifier, List<ListModel>>(
        (ref) => ListsNotifier(ref));
