import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsView extends StatefulWidget {
  @override
  _NewsViewState createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  final String siteUrl = 'https://crackmagazine.net'; // URL del sitio web
  final String apiUrl = 'https://crackmagazine.net/wp-json/wp/v2/posts'; // API de WordPress
  List<dynamic> posts = [];
  bool isLoading = false;

  Future<void> fetchNews() async {
    setState(() {
      isLoading = true;
    });

    final response = await http.get(Uri.parse('$apiUrl?per_page=3')); // Obtener las últimas 3 noticias

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        posts = data;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to load news');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Últimas Noticias de Vogue'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Logo de Vogue
                Image.asset(
                  'assets/web.png', // URL del logo (puedes cambiarla)
                  width: 100,
                  height: 100,
                ),
                SizedBox(height: 20),
                // Lista de noticias
                Expanded(
                  child: ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        child: ListTile(
                          title: Text(
                            post['title']['rendered'],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            post['excerpt']['rendered']
                                .replaceAll(RegExp(r'<[^>]*>'), ''), // Eliminar etiquetas HTML
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}