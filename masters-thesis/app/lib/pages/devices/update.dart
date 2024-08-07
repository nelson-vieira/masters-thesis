// SPDX-License-Identifier: AGPL-3.0-or-later
//
// Copyright (c) 2024 Nelson Vieira
//
// @author Nelson Vieira <2080511@student.uma.pt>
// @license AGPL-3.0 <https://www.gnu.org/licenses/agpl-3.0.txt>
import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:latlong2/latlong.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:dropdown_button2/dropdown_button2.dart";
import "package:iotprivacy/models/user.dart";
import "package:iotprivacy/models/device.dart";
import "package:iotprivacy/helpers/category.dart";

class Update extends StatefulWidget {
  static const String route = "/update";

  final Device device;
  const Update({super.key, required this.device});

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  final controllerName = TextEditingController();
  String? selectedCategory;
  final controllerPurpose = TextEditingController();
  final controllerWhoHasAccess = TextEditingController();
  final controllerTimeStored = TextEditingController();
  var controllerIdentifiable = false;
  final controllerWhatsDone = TextEditingController();
  final controllerPrivacyOptions = TextEditingController();
  var controllerLatitude;
  var controllerLongitude;
  final controllerOwner = TextEditingController();

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

  @override
  initState() {
    // https://github.com/flutter/flutter/issues/9969
    controllerName.text = widget.device.name;
    selectedCategory = widget.device.category;
    controllerPurpose.text = widget.device.purpose;
    controllerWhoHasAccess.text = widget.device.whoHasAccess;
    controllerTimeStored.text = widget.device.timeStored;
    controllerIdentifiable = widget.device.identifiable;
    controllerWhatsDone.text = widget.device.whatsDone;
    controllerPrivacyOptions.text = widget.device.privacyOptions;
    controllerLatitude = widget.device.latitude;
    controllerLongitude = widget.device.longitude;
    controllerOwner.text = widget.device.owner;
    super.initState();
  }

  AlertDialog confirmDelete() => AlertDialog(
        title: const Text("Confirmation"),
        titleTextStyle: const TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
        actionsOverflowButtonSpacing: 20,
        actions: [
          ElevatedButton(
              onPressed: () {
                final docDevice = FirebaseFirestore.instance
                    .collection("devices")
                    .doc(widget.device.id);
                docDevice.delete();
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Text("Yes")),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("No")),
        ],
        content: const Text("Are you sure you want to delete this device?"),
      );

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

  Stream<List<UserDocument>> readUserDocuments() => FirebaseFirestore.instance
      .collection("users")
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => UserDocument.fromJson(doc.data()))
          .toList());

  Widget buildDelete(UserDocument user) => ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 207, 30, 30),
        padding: const EdgeInsets.only(
            left: 0.0, top: 18.0, right: 0.0, bottom: 18.0),
      ),
      child: Text(
        AppLocalizations.of(context)!.delete,
        style: const TextStyle(fontSize: 16.0, color: Colors.white),
      ),
      onPressed: () {
        showDialog(context: context, builder: (context) => confirmDelete());
      });

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
          AppLocalizations.of(context)!.update,
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
                              color: Color(0xFFAAAAAA),
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
                    width: 0.5,
                    color: Colors.white,
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
                        color: Color.fromARGB(255, 170, 170, 170)),
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
                    backgroundColor: const Color(0xFFAFAD15),
                    padding: const EdgeInsets.only(
                        left: 0.0, top: 18.0, right: 0.0, bottom: 18.0),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.update,
                    style: const TextStyle(fontSize: 16.0, color: Colors.white),
                  ),
                  onPressed: () {
                    final docDevice = FirebaseFirestore.instance
                        .collection("devices")
                        .doc(widget.device.id);
                    docDevice.update({
                      "name": controllerName.text,
                      "category": selectedCategory.toString(),
                      "purpose": controllerPurpose.text,
                      "whoHasAccess": controllerWhoHasAccess.text,
                      "timeStored": controllerTimeStored.text,
                      "identifiable": controllerIdentifiable,
                      "whatsDone": controllerWhatsDone.text,
                      "privacyOptions": controllerPrivacyOptions.text,
                      "latitude": controllerLatitude.toString(),
                      "longitude": controllerLongitude.toString(),
                      "owner": controllerOwner.text,
                      "updatedAt": DateTime.now(),
                    });
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  }),
              const SizedBox(
                height: 60,
              ),
              FutureBuilder(
                  future: readUserDocuments().first,
                  builder: (context, snapshot) {
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
                    } else if (snapshot.hasData) {
                      final devices = snapshot.data!;

                      return FirebaseAuth.instance.currentUser != null &&
                              FirebaseAuth.instance.currentUser!.uid ==
                                  devices.first.id &&
                              devices.first.role == "admin"
                          ? buildDelete(devices.first)
                          : Container();
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
