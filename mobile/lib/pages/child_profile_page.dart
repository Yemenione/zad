import 'package:flutter/material.dart';

class ChildProfilePage extends StatefulWidget {
  @override
  _ChildProfilePageState createState() => _ChildProfilePageState();
}

class _ChildProfilePageState extends State<ChildProfilePage> {
  final List<String> _allergies = [];
  final TextEditingController _controller = TextEditingController();

  void _addAllergen(String val) {
    if (val.isNotEmpty && !_allergies.contains(val)) {
      setState(() {
        _allergies.add(val);
      });
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Child Health Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Add Allergies/Sensitivities:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Enter allergen (e.g. Peanuts)",
                suffixIcon: IconButton(icon: Icon(Icons.add), onPressed: () => _addAllergen(_controller.text)),
              ),
              onSubmitted: _addAllergen,
            ),
            SizedBox(height: 20),
            Wrap(
              spacing: 8.0,
              children: _allergies.map((allergy) {
                return Chip(
                  label: Text(allergy),
                  onDeleted: () {
                    setState(() {
                      _allergies.remove(allergy);
                    });
                  },
                );
              }).toList(),
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Profile saved! (Simulation)")));
                },
                child: Text("Save Profile"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
