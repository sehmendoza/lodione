<<<<<<< HEAD
import 'package:uuid/uuid.dart';

final uuid = const Uuid().v4();
=======
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';


const uuid = Uuid();
>>>>>>> bf0ebe4 (d)

class PlaceModel {
  final String id;
  String name;
  String location;
  String details;

  PlaceModel(
<<<<<<< HEAD
      {required this.name, required this.location, required this.details})
      : id = uuid;
=======
      {required this.name, required this.location, required this.details,})
      : id = uuid.v4();
>>>>>>> bf0ebe4 (d)
}
