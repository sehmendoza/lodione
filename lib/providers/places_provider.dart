import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/places_model.dart';

class PlacesNotifier extends StateNotifier<List<PlaceModel>> {
  PlacesNotifier() : super([]);

  void setPlaces(List<PlaceModel> places) {
    state = places;
  }

  void addPlace(PlaceModel place) {
    state = [...state, place];
  }

  void removePlace(PlaceModel place) {
    state = state.where((p) => p != place).toList();
  }

  void updatePlace(int index, PlaceModel newPlace) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index) newPlace else state[i],
    ];
  }
}

final placesProvider =
    StateNotifierProvider<PlacesNotifier, List<PlaceModel>>((ref) {
  return PlacesNotifier();
});
