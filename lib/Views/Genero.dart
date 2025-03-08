import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GenderView extends StatefulWidget {
  @override
  _GenderViewState createState() => _GenderViewState();
}

class _GenderViewState extends State<GenderView> {
  String name = '';
  String gender = '';
  Color backgroundColor = Colors.white;

  Future<void> predictGender() async {
    final response = await http.get(Uri.parse('https://api.genderize.io/?name=$name'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        gender = data['gender'];
        backgroundColor = gender == 'male' ? Colors.blue : Colors.pink;
      });
    } else {
      throw Exception('Failed to load gender');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Predecir Género'),
      ),
      backgroundColor: backgroundColor,
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
              onPressed: predictGender,
              child: Text('Predecir Género'),
            ),
            SizedBox(height: 20),
            Text('Género: $gender'),
          ],
        ),
      ),
    );
  }
}