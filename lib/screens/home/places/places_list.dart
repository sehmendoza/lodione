import 'package:flutter/material.dart';

import '../../../models/places_model.dart';
import 'place_details.dart';

class PlacesListView extends StatelessWidget {
  const PlacesListView(
      {super.key, required this.places, required this.openOption});

  final List<PlaceModel> places;
  final void Function(PlaceModel place) openOption;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: places.length,
              itemBuilder: (context, index) {
                PlaceModel place = places[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    key: ValueKey(place.id),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PlaceDetails(place: place),
                        ),
                      );
                    },
                    onLongPress: () {
                      openOption(place);
                    },
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(10)),
                    title: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            place.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          place.details == ''
                              ? const SizedBox()
                              : Text(
                                  place.details,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                        ],
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(place.location,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
