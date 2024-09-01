import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/places_model.dart';

class PlacesNotifier extends StateNotifier<List<PlaceModel>> {
  PlacesNotifier() : super([]);

  void setPlaces(List<PlaceModel> places) {
    state = places;
  }

  Future<void> fetchPlaces() async {
    state = state;
  }

  void addPlace(PlaceModel place) {
    state = [place, ...state];
  }

  void removePlace(PlaceModel place) {
    state = state.where((p) => p != place).toList();
  }

  void updatePlace(PlaceModel newPlace) {
    state = state.map((place) {
      if (place.id == newPlace.id) {
        return newPlace;
      }
      return place;
    }).toList();
  }
}

final placesProvider =
    StateNotifierProvider<PlacesNotifier, List<PlaceModel>>((ref) {
  return PlacesNotifier();
});
