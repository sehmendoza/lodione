import 'package:flutter/material.dart';

class PlaceModel {
  String id;
  String name;
  String location;
  String details;

  PlaceModel(
      {required this.name, required this.location, required this.details})
      : id = UniqueKey().toString();
}
