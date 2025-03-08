import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UniversityView extends StatefulWidget {
  @override
  _UniversityViewState createState() => _UniversityViewState();
}

class _UniversityViewState extends State<UniversityView> {
  String countryName = '';
  List<dynamic> universities = [];
  bool isLoading = false;

  Future<void> fetchUniversities() async {
    if (countryName.isEmpty) return;

    setState(() {
      isLoading = true;
    });

    final response = await http.get(
      Uri.parse('http://universities.hipolabs.com/search?country=$countryName'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        universities = data;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to load universities');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Universidades de $countryName'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Ingresa el nombre de un país en inglés',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  countryName = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: fetchUniversities,
              child: Text('Buscar Universidades'),
            ),
            SizedBox(height: 20),
            isLoading
                ? CircularProgressIndicator()
                : Expanded(
                    child: ListView.builder(
                      itemCount: universities.length,
                      itemBuilder: (context, index) {
                        final university = universities[index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            title: Text(university['name'] ?? 'Nombre no disponible'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Dominio: ${university['domains']?.join(', ') ?? 'No disponible'}'),
                                if (university['web_pages'] != null && university['web_pages'].isNotEmpty)
                                  GestureDetector(
                                    onTap: () {
                                      // Abrir el enlace en el navegador
                                      final url = university['web_pages'][0];
                                      if (url != null && url.isNotEmpty) {
                                        // Usar un paquete como url_launcher para abrir el enlace
                                        // Ejemplo: https://pub.dev/packages/url_launcher
                                        print('Abrir: $url');
                                      }
                                    },
                                    child: Text(
                                      'Página web: ${university['web_pages'][0]}',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}