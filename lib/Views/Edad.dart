import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AgeView extends StatefulWidget {
  @override
  _AgeViewState createState() => _AgeViewState();
}

class _AgeViewState extends State<AgeView> {
  String name = '';
  int age = 0;
  String ageGroup = '';
  String imagePath = '';

  Future<void> predictAge() async {
    final response = await http.get(Uri.parse('https://api.agify.io/?name=$name'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        age = data['age'];
        if (age < 18) {
          ageGroup = 'Joven';
          imagePath = 'assets/young.png';
        } else if (age >= 18 && age < 60) {
          ageGroup = 'Adulto';
          imagePath = 'assets/adult.png';
        } else {
          ageGroup = 'Anciano';
          imagePath = 'assets/old.png';
        }
      });
    } else {
      throw Exception('Failed to load age');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Predecir Edad'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              },
              decoration: InputDecoration(labelText: 'Ingresa un nombre'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: predictAge,
              child: Text('Predecir Edad'),
            ),
            SizedBox(height: 20),
            Text('Edad: $age'),
            Text('Grupo de edad: $ageGroup'),
            if (imagePath.isNotEmpty)
              Image.asset(imagePath, width: 200, height: 200),
          ],
        ),
      ),
    );
  }
}