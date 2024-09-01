import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lodione/models/list_model.dart';
import 'package:lodione/models/user_model.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);
final listsProvider = StateProvider<List<ListModel>>((ref) => []);
