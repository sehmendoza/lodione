import 'package:uuid/uuid.dart';

final uuid = const Uuid().v4();

class PlaceModel {
  String id;
  String name;
  String location;
  String details;

  PlaceModel(
      {required this.name, required this.location, required this.details})
      : id = uuid;
}
