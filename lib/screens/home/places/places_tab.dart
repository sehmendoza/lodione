import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lodione/providers/places_provider.dart';
import 'package:lodione/screens/home/places/places_list.dart';
import 'package:lodione/widgets/buttons.dart';
import '../../../models/places_model.dart';

final url = Uri.https(
    'lodione-lifestyle-default-rtdb.firebaseio.com', 'gotoPlace.json');

class GotoPlaces extends ConsumerStatefulWidget {
  const GotoPlaces({super.key});

  @override
  ConsumerState<GotoPlaces> createState() => _GotoPlacesState();
}

class _GotoPlacesState extends ConsumerState<GotoPlaces> {
  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    final places = ref.watch(placesProvider);
=======
    List<PlaceModel> places = ref.watch(placesProvider);

>>>>>>> bf0ebe4 (d)
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, top: 10),
          child: Row(
            children: [
              const Text(
                'Go to Places:',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              MyButton(
                text: 'Add',
                icon: Icons.add,
                onPressed: addRestaurant,
              ),
            ],
          ),
        ),
<<<<<<< HEAD
        PlacesListView(places: places, openOption: openOption)
=======
        places.isEmpty
            ? const Column(children: [
                SizedBox(height: 240),
                Center(
                    child: Text('No added places yet.',
                        style: TextStyle(
                          color: Colors.white70,
                        )))
              ])
            : Expanded(
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
                              onLongPress: () {
                                openOption(place);
                              },
                              shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      color: Colors.white, width: 2),
                                  borderRadius: BorderRadius.circular(10)),
                              title: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      place.name,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    place.details == ''
                                        ? const SizedBox()
                                        : Text(
                                            place.details,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
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
                              // trailing: IconButton(
                              //   onPressed: () {
                              //     //  launchMapsUrl(place.location);
                              //   },
                              //   icon: const Icon(Icons.location_on_outlined,
                              //       color: Colors.white, size: 30.0),
                              // ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
>>>>>>> bf0ebe4 (d)
      ],
    );
  }

  void addRestaurant() {
    TextEditingController nameController = TextEditingController();
    TextEditingController locationController = TextEditingController();
    TextEditingController detailController = TextEditingController();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: Colors.white, width: 2)),
            title: const Center(
              child: Text(
                'Add Restaurant',
                style: TextStyle(color: Colors.white),
              ),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  gotoTextfield(
                      nameController: nameController,
                      hintText: 'Restaurant Name'),
                  const SizedBox(height: 10),
                  gotoTextfield(
                      nameController: locationController, hintText: 'Location'),
                  const SizedBox(height: 10),
                  gotoTextfield(
                      nameController: detailController, hintText: 'Details'),
                ],
              ),
            ),
            actionsAlignment: MainAxisAlignment.spaceBetween,
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    side: const BorderSide(color: Colors.white, width: 2)),
                onPressed: () async {
                  if (nameController.text.isEmpty &&
                      locationController.text.isEmpty) {
                    return;
                  } else {
                    setState(() {
                      ref.read(placesProvider.notifier).addPlace(
                            PlaceModel(
                                name: nameController.text,
                                location: locationController.text,
                                details: detailController.text),
                          );
                    });
                    Navigator.of(context).pop();
                  }
                },
                child: const Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        });
  }

  void editRestaurant(PlaceModel place) {
    TextEditingController nameController =
        TextEditingController(text: place.name);
    TextEditingController locationController =
        TextEditingController(text: place.location);
    TextEditingController detailController =
        TextEditingController(text: place.details);
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: Colors.white, width: 2)),
            title: const Center(
              child: Text(
                'Edit Restaurant',
                style: TextStyle(color: Colors.white),
              ),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  gotoTextfield(
                      nameController: nameController,
                      hintText: 'Restaurant Name'),
                  const SizedBox(height: 10),
                  gotoTextfield(
                      nameController: locationController, hintText: 'Location'),
                  const SizedBox(height: 10),
                  gotoTextfield(
                      nameController: detailController, hintText: 'Details'),
                ],
              ),
            ),
            actionsAlignment: MainAxisAlignment.spaceBetween,
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    side: const BorderSide(color: Colors.white, width: 2)),
                onPressed: () async {
                  if (nameController.text.isEmpty &&
                      locationController.text.isEmpty) {
                    return;
                  } else {
                    setState(() {
                      place.name = nameController.text;
                      place.details = detailController.text;
                      place.location = locationController.text;
                      ref.read(placesProvider.notifier).updatePlace(place);
                    });
                    Navigator.of(context).pop();
                  }
                },
                child: const Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        });
  }

  void openOption(PlaceModel place) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(color: Colors.white, width: 2)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.white, width: 1),
                        borderRadius: BorderRadius.circular(20)),
                    title: const Center(
                      child: Text(
                        'Edit Restaurant',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      editRestaurant(place);
                    },
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.white, width: 1),
                        borderRadius: BorderRadius.circular(20)),
                    title: const Center(
                      child: Text(
                        'Delete Restaurant',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        ref.read(placesProvider.notifier).removePlace(place);
                      });

                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ));
  }
}

Widget gotoTextfield(
    {required TextEditingController nameController, required String hintText}) {
  return TextField(
    style: const TextStyle(color: Colors.white),
    controller: nameController,
    decoration: InputDecoration(
        hintText: hintText, hintStyle: const TextStyle(color: Colors.white70)),
  );
}
