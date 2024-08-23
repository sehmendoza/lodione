import 'package:flutter/material.dart';
import 'package:lodione/widgets/buttons.dart';
import 'package:http/http.dart' as http;
import '../../../models/places_model.dart';

final url = Uri.https(
    'lodione-lifestyle-default-rtdb.firebaseio.com', 'gotoPlace.json');

class GotoPlaces extends StatefulWidget {
  const GotoPlaces({super.key});

  @override
  State<GotoPlaces> createState() => _GotoPlacesState();
}

class _GotoPlacesState extends State<GotoPlaces> {
  List<PlaceModel> places = [
    PlaceModel(
        name: 'Jollibee', location: 'Scarborough', details: 'Very nice food'),
    PlaceModel(
        name: 'McDonalds', location: 'North York', details: 'Garbage food'),
    PlaceModel(name: 'McDonalds', location: 'North York', details: ''),
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
                                fontWeight: FontWeight.bold),
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
                onPressed: () {
                  if (nameController.text.isEmpty &&
                      locationController.text.isEmpty) {
                    return;
                  } else {
                    http.post(url);
                    setState(() {
                      places.add(PlaceModel(
                          name: nameController.text,
                          location: locationController.text,
                          details: detailController.text));
                      Navigator.pop(context);
                    });
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
                        'Edit Restaurant Name',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      editRestaurantName(place);
                    },
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.white, width: 1),
                        borderRadius: BorderRadius.circular(20)),
                    title: const Center(
                      child: Text(
                        'Edit Restaurant Address',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      editRestaurantLocation(place);
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
                      places.removeAt(places.indexOf((place)));
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ));
  }

  void editRestaurantName(PlaceModel place) {
    TextEditingController nameController =
        TextEditingController(text: place.name);
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: Colors.white, width: 2)),
            title: const Text('Edit Place Name',
                style: TextStyle(color: Colors.white)),
            content: gotoTextfield(
                nameController: nameController, hintText: 'Place Name'),
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
                onPressed: () {
                  setState(() {
                    place.name = nameController.text;
                  });

                  Navigator.pop(context);
                },
                child:
                    const Text('Save', style: TextStyle(color: Colors.white)),
              ),
            ],
          );
        });
  }

  void editRestaurantLocation(PlaceModel place) {
    TextEditingController locationController =
        TextEditingController(text: place.location);

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: Colors.white, width: 2)),
            title: const Text('Edit Restaurant Location',
                style: TextStyle(color: Colors.white)),
            content: gotoTextfield(
                nameController: locationController,
                hintText: 'Restaurant Location'),
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
                onPressed: () {
                  setState(() {
                    place.location = locationController.text;
                  });

                  Navigator.pop(context);
                },
                child:
                    const Text('Save', style: TextStyle(color: Colors.white)),
              ),
            ],
          );
        });
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
