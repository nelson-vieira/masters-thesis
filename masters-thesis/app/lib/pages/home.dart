import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:latlong2/latlong.dart";
import "package:app/widgets/drawer.dart";

class HomePage extends StatelessWidget {
  static const String route = "/";

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      drawer: buildDrawer(context, route),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 8, bottom: 8),
              child: Text('This is a map that is showing (32.778295173354356, -16.737781931587615).'),
            ),
            Flexible(
              child: FlutterMap(
                options: MapOptions(
                  center: LatLng(32.778295173354356, -16.737781931587615),
                  zoom: 9,
                ),
                nonRotatedChildren: [
                  AttributionWidget.defaultWidget(
                    source: 'OpenStreetMap contributors',
                    onSourceTapped: () {},
                  ),
                ],
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'me.nelsonvieira.iot_privacy_app',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
