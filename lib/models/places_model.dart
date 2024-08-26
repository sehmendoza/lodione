import 'package:uuid/uuid.dart';

const uuid = Uuid();

class PlaceModel {
  String id;
  String name;
  String location;
  String details;

  PlaceModel({
    required this.name,
    required this.location,
    required this.details,
    String? id,
  }) : id = id ?? uuid.v4();
}
