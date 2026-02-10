import 'package:flutter/material.dart';
import 'pages/child_profile_page.dart';
import 'pages/menu_page.dart';

void main() {
  runApp(ZaadApp());
}

class ZaadApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zaad',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Zaad - School Meal Guard")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.health_and_safety, size: 80, color: Colors.blue),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ChildProfilePage()),
              ),
              child: Text("Setup Child Profile (Allergies)"),
              style: ElevatedButton.styleFrom(minimumSize: Size(250, 50)),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => MenuPage()),
              ),
              child: Text("Browse School Menu"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(250, 50),
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
