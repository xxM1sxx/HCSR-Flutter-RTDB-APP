import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'model/sensormodel.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final DatabaseReference _database = FirebaseDatabase.instance.ref().child('sensor');
  SensorModel? _sensorData;

  @override
  void initState() {
    super.initState();
    _setupRealtimeUpdate();
  }

  void _setupRealtimeUpdate() {
    _database.onValue.listen((event) {
      if (event.snapshot.value != null) {
        setState(() {
          _sensorData = SensorModel.fromJson(
              Map<String, dynamic>.from(event.snapshot.value as Map));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sensor Dashboard'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Jarak Sensor:',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 10),
            Text(
              '${_sensorData?.jarak ?? "Loading..."} cm',
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
