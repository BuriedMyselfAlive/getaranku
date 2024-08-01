import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:getaranku/screen/index.dart';
import 'package:getaranku/screen/history.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'local_notif.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotifications.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Index(),
    History(),
  ];
  @override
  void initState() {
    super.initState();

    // Inisialisasi Firebase Database
    DatabaseReference reference = _database.ref().child('test');
    reference.onValue.listen((event) {
      var data = event.snapshot.value as Map<String, dynamic>;
      double sensorValue = data['sensor'] ?? 0.0;

      // Cek apakah nilai sensor lebih dari 5
      if (sensorValue > 5) {
        // Panggil fungsi untuk menampilkan notifikasi
        LocalNotifications.showNotification(title : 'Getaranku',body: 'Awas Gempa!!!',payload: 'getaran terdeteksi dengan skala $sensorValue Hz');
      }
    });

    // Inisialisasi Flutter Local Notifications
    var initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          currentIndex: _selectedIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'History',
            ),
          ],
        ),
      ),
    );
  }
}
