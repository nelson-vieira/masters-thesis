// SPDX-License-Identifier: AGPL-3.0-or-later
//
// Copyright (c) 2023 Nelson Vieira
//
// @author Nelson Vieira <2080511@student.uma.pt>
// @license AGPL-3.0 <https://www.gnu.org/licenses/agpl-3.0.txt>
import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:latlong2/latlong.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:dropdown_button2/dropdown_button2.dart";
import "package:iotprivacy/models/device.dart";
import "package:iotprivacy/helpers/category.dart";

class Create extends StatefulWidget {
  static const String route = "/create";

  const Create({super.key});

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
  final controllerName = TextEditingController();
  String? selectedCategory;
  final controllerPurpose = TextEditingController();
  final controllerWhoHasAccess = TextEditingController();
  final controllerTimeStored = TextEditingController();
  bool controllerIdentifiable = false;
  final controllerWhatsDone = TextEditingController();
  final controllerPrivacyOptions = TextEditingController();
  var controllerLatitude;
  var controllerLongitude;
  final controllerOwner = TextEditingController();
  final controllerCreatedAt = TextEditingController();
  final controllerUpdatedAt = TextEditingController();

  InputDecoration decoration(String label) => InputDecoration(
        labelText: label,
        enabledBorder: const OutlineInputBorder(
          borderSide:
              BorderSide(color: Color.fromARGB(255, 255, 255, 255), width: 0.0),
        ),
        border: const OutlineInputBorder(),
        labelStyle: const TextStyle(
          color: Color(0xFFAAAAAA),
        ),
      );

  Future createDevice(Device device) async {
    final docDevice = FirebaseFirestore.instance.collection("devices").doc();
    device.id = docDevice.id;

    final json = device.toJson();
    await docDevice.set(json);
  }

  Dialog controllerCoordinates() => Dialog(
        child: SizedBox.expand(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              children: [
                Flexible(
                  child: FlutterMap(
                    options: MapOptions(
                      center: LatLng(32.778295173354356, -16.737781931587615),
                      interactiveFlags:
                          InteractiveFlag.all & ~InteractiveFlag.rotate,
                      zoom: 9,
                      onLongPress: (tapPosition, point) {
                        setState(() {
                          controllerLatitude = point.latitude;
                          controllerLongitude = point.longitude;
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                    nonRotatedChildren: [
                      AttributionWidget.defaultWidget(
                        source: "OpenStreetMap",
                        onSourceTapped: null,
                      ),
                    ],
                    children: [
                      TileLayer(
                        urlTemplate:
                            "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                        userAgentPackageName: "me.nelsonvieira.iotprivacy",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Color.fromARGB(255, 255, 255, 255)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          AppLocalizations.of(context)!.addDevice,
          style: const TextStyle(fontSize: 30),
        ),
        backgroundColor: const Color(0xFF334150),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 2.0, right: 4.0, left: 4.0, bottom: 4.0),
        child: Container(
          color: const Color.fromARGB(255, 16, 44, 53),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: <Widget>[
              TextField(
                controller: controllerName,
                decoration:
                    decoration(AppLocalizations.of(context)!.nameAttribute),
                style: const TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              const SizedBox(height: 24),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("categories")
                      .snapshots(),
                  builder: (context, snapshot) {
                    List<DropdownMenuItem<String>> categoryItems = [];
                    if (snapshot.hasError) {
                      return Center(
                          child: Text(
                        AppLocalizations.of(context)!
                            .firebaseError("${snapshot.error}"),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17.0,
                        ),
                        textAlign: TextAlign.center,
                      ));
                    } else if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      final categories = snapshot.data?.docs.reversed.toList();

                      for (var category in categories!) {
                        categoryItems.add(
                          DropdownMenuItem<String>(
                              value: category.id,
                              child: Text(
                                CategoryHelper.categoryName(
                                    context, category["name"]),
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                              )),
                        );
                      }

                      return DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isExpanded: true,
                          hint: Text(
                            AppLocalizations.of(context)!.categoryAttribute,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 170, 170, 170),
                            ),
                          ),
                          barrierColor: const Color.fromARGB(132, 16, 44, 53),
                          barrierLabel:
                              AppLocalizations.of(context)!.categoryAttribute,
                          value: selectedCategory,
                          onChanged: (categoryValue) {
                            setState(() {
                              selectedCategory = categoryValue;
                            });
                          },
                          items: categoryItems,
                          buttonStyleData: ButtonStyleData(
                            padding: const EdgeInsets.only(
                                top: 7.0, right: 10.0, left: 0.0, bottom: 7.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Colors.white,
                                width: 0.5,
                              ),
                            ),
                          ),
                          dropdownStyleData: DropdownStyleData(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(255, 16, 44, 53),
                            ),
                            scrollbarTheme: ScrollbarThemeData(
                              radius: const Radius.circular(10),
                              thickness: MaterialStateProperty.all(6),
                              thumbVisibility: MaterialStateProperty.all(true),
                            ),
                          ),
                        ),
                      );
                    }
                  }),
              const SizedBox(
                height: 24,
              ),
              TextField(
                controller: controllerPurpose,
                decoration:
                    decoration(AppLocalizations.of(context)!.purposeAttribute),
                style: const TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              TextField(
                controller: controllerWhoHasAccess,
                decoration: decoration(
                    AppLocalizations.of(context)!.whoHasAccessAttribute),
                style: const TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              TextField(
                controller: controllerTimeStored,
                decoration: decoration(
                    AppLocalizations.of(context)!.timeStoredAttribute),
                style: const TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Theme(
                data: ThemeData(unselectedWidgetColor: Colors.white),
                child: CheckboxListTile(
                  checkboxShape: const RoundedRectangleBorder(
                    side: BorderSide(color: Color(0xFFFFFFFF), width: 2.0),
                  ),
                  activeColor: const Color(0xFF6CBBE0),
                  checkColor: const Color(0xAAFFFFFF),
                  enableFeedback: true,
                  title: Text(
                    AppLocalizations.of(context)!.identifiableAttribute,
                    style: TextStyle(
                      color: controllerIdentifiable
                          ? const Color(0xFFFFFFFF)
                          : const Color(0xFFAAAAAA),
                    ),
                  ),
                  value: controllerIdentifiable,
                  onChanged: (bool? value) {
                    setState(() {
                      controllerIdentifiable = value!;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              TextField(
                controller: controllerWhatsDone,
                decoration: decoration(
                    AppLocalizations.of(context)!.whatsDoneAttribute),
                style: const TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              TextField(
                controller: controllerPrivacyOptions,
                decoration: decoration(
                    AppLocalizations.of(context)!.privacyOptionsAttribute),
                style: const TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 16, 44, 53),
                  padding: const EdgeInsets.only(
                      left: 10.0, top: 20.0, right: 0.0, bottom: 20.0),
                  side: const BorderSide(
                      width: 0.5, // the thickness
                      color: Colors.white // the color of the border
                      ),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    controllerLatitude == null
                        ? AppLocalizations.of(context)!.coordinatesAttribute
                        : "Lat: ${controllerLatitude.toString()}, Long: ${controllerLongitude.toString()}",
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Color.fromARGB(255, 170, 170, 170),
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => controllerCoordinates());
                },
              ),
              const SizedBox(
                height: 24,
              ),
              TextField(
                controller: controllerOwner,
                decoration: decoration(
                    AppLocalizations.of(context)!.deviceOwnerAttribute),
                style: const TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0A8A4E),
                  padding: const EdgeInsets.only(
                      left: 0.0, top: 18.0, right: 0.0, bottom: 18.0),
                ),
                onPressed: () {
                  final device = Device(
                    name: controllerName.text.trim(),
                    category: selectedCategory.toString(),
                    purpose: controllerPurpose.text.trim(),
                    whoHasAccess: controllerWhoHasAccess.text.trim(),
                    timeStored: controllerTimeStored.text.trim(),
                    identifiable: controllerIdentifiable,
                    whatsDone: controllerWhatsDone.text.trim(),
                    privacyOptions: controllerPrivacyOptions.text.trim(),
                    latitude: controllerLatitude.toString(),
                    longitude: controllerLongitude.toString(),
                    owner: controllerOwner.text.trim(),
                    createdAt: DateTime.now(),
                    updatedAt: DateTime.now(),
                  );
                  createDevice(device);
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: Text(
                  AppLocalizations.of(context)!.createDevice,
                  style: const TextStyle(fontSize: 16.0, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
