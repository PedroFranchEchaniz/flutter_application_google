import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_google/models/fontain_response/fontain_response.dart';
import 'package:flutter_application_google/models/fontain_response/result.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<FontainResponse> fetchFountain() async {
  final response = await http.get(Uri.parse(
      'https://valencia.opendatasoft.com/api/explore/v2.1/catalog/datasets/fonts-daigua-publica-fuentes-de-agua-publica/records?limit=20'));

  if (response.statusCode == 200) {
    Map<String, dynamic> decodedJson = json.decode(response.body);
    return FontainResponse.fromJson(decodedJson);
  } else {
    throw Exception('Failed');
  }
}

class Fountains extends StatefulWidget {
  const Fountains({super.key});

  @override
  State<Fountains> createState() => _FountainsState();
}

class _FountainsState extends State<Fountains> {
  late Future<FontainResponse> fountains;

  final _initialCameraPostion = const CameraPosition(
      target: LatLng(37.38049329951381, -6.007534638184238), zoom: 15);

  @override
  void initState() {
    super.initState();
    fountains = fetchFountain();
  }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fountains,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData) {
          return const Text('No hay datos');
        } else {
          final fontainList = snapshot.data!.results;

          return Scaffold(
            body: GoogleMap(
              mapType: MapType.hybrid,
              initialCameraPosition: _initialCameraPostion,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: Set<Marker>.from(
                fontainList!.map(
                  (fuentes) => Marker(
                    markerId: MarkerId(fuentes.calle.toString()),
                    position: LatLng(
                        fuentes.geoPoint2d!.lat!, fuentes.geoPoint2d!.lon!),
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
