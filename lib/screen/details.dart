import 'package:flutter/material.dart';

class details extends StatelessWidget {

  // Additional properties
  final String latitude;
  final String longitude;
  final String sensorData;

  details({super.key,
    required this.latitude,
    required this.longitude,
    required this.sensorData,
  });


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Latitude: $latitude'),
            Text('Longitude: $longitude'),
            Text('Sensor Data: $sensorData'),
            // Add other UI elements as needed
          ],
        ),
      ),
    );
  }
}
