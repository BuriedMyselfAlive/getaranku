import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:getaranku/screen/details.dart';

class History extends StatelessWidget {
  const History({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: StreamBuilder<DatabaseEvent>(
        stream: FirebaseDatabase.instance.ref('history').onValue,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
            final historyList = data.values.toList();
            if (historyList.isEmpty) {
              // If the historyList is empty, display an empty state.
              return Center(
                child: Text('No data available'),
              );
            }
            historyList.sort((a, b) {
              DateTime timestampA = DateTime.parse(a['timestamp']);
              DateTime timestampB = DateTime.parse(b['timestamp']);
              return timestampA.compareTo(timestampB);
            });
            List sortedList = historyList.reversed.toList();

            return Column(
              children: [
                // Line Chart
                Container(
                  margin: const EdgeInsets.all(8.0),
                  height: MediaQuery.of(context).size.height * 0.28,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Stack(
                  children: [LineChart(
                    LineChartData(
                      gridData: FlGridData(show: true),
                      titlesData: const FlTitlesData(
                          leftTitles : AxisTitles(sideTitles: SideTitles(reservedSize: 44, showTitles: true)),
                          topTitles : AxisTitles(sideTitles: SideTitles(reservedSize: 30, showTitles: false)),
                          rightTitles : AxisTitles(sideTitles: SideTitles(reservedSize: 44, showTitles: false)),
                          bottomTitles : AxisTitles(axisNameWidget:Text("tanggal"), sideTitles: SideTitles(reservedSize: 0, showTitles: false)),
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: Border.all(color: const Color(0xff37434d), width: 1),
                      ),
                      minX: 0,
                      maxX: historyList.length.toDouble(),
                      minY: 0,
                      maxY: historyList.map((item) => item['sensor'] ?? 0.0).reduce((value, element) => value > element ? value : element), // Sesuaikan dengan rentang data sensor Anda
                      lineBarsData: [
                        LineChartBarData(
                          spots: historyList.map((item) {
                            return FlSpot(
                              historyList.indexOf(item).toDouble(),
                              double.parse(item['sensor'].toString()),
                            );
                          }).toList(),
                          isCurved: true,
                          color: Colors.blue,
                          belowBarData: BarAreaData(show: false),
                        ),
                      ],
                    ),
                ),
                    Positioned(
                      top: 10.0,
                      right: 10.0,
                      child: Container(
                        padding: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(3.0),
                        ),
                        child: Text(
                          'Frekuensi Getaran (SI)',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                  ),
                ),
                // List View for Sensor Data
                Expanded(
                  child: ListView.builder(
                    itemCount: sortedList.length,
                    itemBuilder: (context, index) {
                      final item = sortedList[index] as Map<dynamic, dynamic>;
                      return GestureDetector(
                        onTap: () {
                          // Handle details display (e.g., navigate to a details page)
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => details(
                                latitude: item['lat'].toString(),
                                longitude: item['long'].toString(),
                                sensorData: item['sensor'].toString(),
                              ),
                            ),
                          );
                        },
                        child: ListTile(
                          title: Text(item['timestamp'].toString()),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Latitude: ${item['lat']}'),
                              Text('Longitude: ${item['long']}'),
                              Text('Sensor Data: ${item['sensor']}'),
                            ],
                          ),
                          // Add other UI elements as needed
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
