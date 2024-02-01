import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _initialCameraPostion = const CameraPosition(
      target: LatLng(37.38049329951381, -6.007534638184238), zoom: 15);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GoogleMap(
          initialCameraPosition: _initialCameraPostion,
          myLocationButtonEnabled: false,
          markers: {
            const Marker(
                markerId: MarkerId('Salesianos de Triana'),
                position: LatLng(37.38049329951381, -6.007534638184238))
          }),
    );
  }
}
