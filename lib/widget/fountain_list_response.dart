import 'package:flutter/material.dart';
import 'package:flutter_application_google/models/fontain_response/fontain_response.dart';
import 'package:flutter_application_google/models/fontain_response/result.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<List<Result>> fetchFountain() async {
  final response = await http.get(Uri.parse(
      'https://valencia.opendatasoft.com/api/explore/v2.1/catalog/datasets/fonts-daigua-publica-fuentes-de-agua-publica/records?limit=20'));

  if (response.statusCode == 200) {
    List<dynamic> decodeJson = json.decode(response.body)['records'];
    return decodeJson.map((json) => Result.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load fountains');
  }
}

class Fountains extends StatefulWidget {
  const Fountains({super.key});

  @override
  State<Fountains> createState() => _FountainsState();
}

class _FountainsState extends State<Fountains> {
  late Future<List<Result>> fountains;

  final _initialCameraPostion = const CameraPosition(
      target: LatLng(37.38049329951381, -6.007534638184238), zoom: 15);

  @override
  void initState() {
    super.initState();
    fountains = fetchFountain();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<List<Result>>(
        future: fountains,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No fountains found'));
          } else {
            Set<Marker> markers = snapshot.data!
                .map((fountain) => Marker(
                      markerId: MarkerId(fountain.objectid.toString()),
                      position: LatLng(
                          fountain.geoPoint2d!.lat!, fountain.geoPoint2d!.lon!),
                    ))
                .toSet();

            return GoogleMap(
              initialCameraPosition: _initialCameraPostion,
              myLocationButtonEnabled: false,
              markers: markers,
            );
          }
        },
      ),
    );
  }
}
