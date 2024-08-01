import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:intl/intl.dart';

class Index extends StatelessWidget {
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();
  // final MapController mapController = MapController();
  final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
  // final List<CircleMarker> circleMarkers = [];
  final MarkerId markerId = MarkerId("getaran");



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DatabaseEvent>(
        stream: FirebaseDatabase.instance.ref('test').onValue,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final DatabaseEvent event = snapshot.data!;
            final DataSnapshot data = event.snapshot;

            final latitude = data.child('lat').value.toString();
            final longitude = data.child('long').value.toString();
            final sensor = double.parse(data.child('sensor').value.toString());

            if (sensor > 3.9) {
              // Jika sensor lebih dari 3.9, kirim ke history
              // sendToHistory(data);
              // addCircleLayer(double.parse(latitude), double.parse(longitude), Colors.red.withOpacity(0.5));
              Set<Circle> circles = Set.from([Circle(
                circleId: CircleId("getaran"),
                center: LatLng(double.parse(latitude), double.parse(longitude)),
                radius: 300,
                fillColor: Colors.red.withOpacity(0.5)
              )]);
            }
            else{
              Set<Circle> circles = Set.from([Circle(
                circleId: CircleId("getaran"),
                center: LatLng(double.parse(latitude), double.parse(longitude)),
                radius: 300,
                fillColor: Colors.green.withOpacity(0.5)
              )]);
              // addCircleLayer(double.parse(latitude), double.parse(longitude), Colors.green.withOpacity(0.5));
            }
            final Marker marker = Marker(markerId: markerId,position: LatLng(double.parse(latitude), double.parse(longitude)), infoWindow: InfoWindow(
              title: "sensor getaran : "+sensor.toString()+ "SI",
              snippet: latitude.toString() + "," + longitude.toString(),
            ));
            Set<Circle> circles = Set.from([Circle(
                circleId: CircleId("getaran"),
                center: LatLng(double.parse(latitude), double.parse(longitude)),
                radius: 10,
                fillColor: Colors.green.withOpacity(0.5)
            )]);
            // final markerList = [Marker(
            //   key: Key(sensor.toString()),
            //   point: LatLng(double.parse(latitude), double.parse(longitude)),
            //   child: const Icon(Icons.location_on),
            // ),].toList();


            return
            //   FlutterMap(
            //   mapController: mapController,
            //   options: const MapOptions(
            //     initialCenter: const LatLng(-6.97403, 107.63053),
            //     initialZoom: 15,
            //   ),
            //   children: [
            //     TileLayer(
            //       urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            //       userAgentPackageName: 'com.example.app',
            //     ),
            //     CircleLayer(circles: circleMarkers),
            //     PopupMarkerLayer(options: PopupMarkerLayerOptions(
            //       markers: markerList!,
            //       popupController: PopupController(),
            //       popupDisplayOptions: PopupDisplayOptions(
            //       builder: (BuildContext context, Marker marker) =>
            //           Container(
            //             width: MediaQuery.of(context).size.width * 0.6,
            //             height: MediaQuery.of(context).size.width * 0.4,
            //             decoration: BoxDecoration(
            //               color: Colors.white,
            //               borderRadius: BorderRadius.circular(10.0), // Sesuaikan dengan kebutuhan
            //               boxShadow: [
            //                 BoxShadow(
            //                   color: Colors.grey.withOpacity(0.5),
            //                   spreadRadius: 2,
            //                   blurRadius: 5,
            //                   offset: Offset(0, 3),
            //                 ),
            //               ],
            //             ),
            //             child: Column(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: [
            //                 Text('Marker Info', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            //                 SizedBox(height: 8),
            //                 Text('Skala Getaran: ${marker.key!.toString().replaceAll(RegExp(r'[\[\]<>]'),'')} SI'),
            //                 Text('Latitude: ${marker.point.latitude}'),
            //                 Text('Longitude: ${marker.point.longitude}'),
            //               ],
            //             ),
            //           ),
            //       ),
            //     ),)
            //   ],
            // );
              GoogleMap(
                mapType: MapType.hybrid,
                initialCameraPosition: const CameraPosition(target: LatLng(-6.97403, 107.63053)) ,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                markers: {
                  marker
                },
                circles: circles,
              );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  // void sendToHistory(DataSnapshot data) {
  //   final DateTime now = DateTime.now();
  //   final String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
  //
  //   final Map<String, dynamic> historyData = {
  //     'timestamp': formattedDate,
  //     'sensor': data.child('sensor').value.toString(),
  //     'lat': data.child('lat').value.toString(),
  //     'long': data.child('long').value.toString(),
  //   };
  //
  //   // Kirim ke history di Firebase Realtime Database
  //   databaseReference.child('history').push().set(historyData);
  // } yang ini jika diperlukan saja
  // void addCircleLayer(double latitude, double longitude, Color kolor) {
  //   // Check if there is already a circle at the given location
  //   CircleMarker existingCircle = circleMarkers.firstWhere(
  //         (circle) =>
  //     circle.point.latitude == latitude && circle.point.longitude == longitude,
  //     orElse: () => CircleMarker(point: LatLng(latitude, longitude), radius: 100),
  //   );
  //   if (existingCircle != null) {
  //     circleMarkers.removeWhere((circle) =>
  //     circle.point.latitude == latitude && circle.point.longitude == longitude);// Change color to blue
  //   }// Add a new circle if there is no existing circle at the location
  //   CircleMarker newCircleMarker = CircleMarker(
  //     point: LatLng(latitude, longitude),
  //     color: kolor,
  //     radius: 100,
  //   );
  //   circleMarkers.add(newCircleMarker);
  //   }

}
