import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PokemonView extends StatefulWidget {
  @override
  _PokemonViewState createState() => _PokemonViewState();
}

class _PokemonViewState extends State<PokemonView> {
  String pokemonName = '';
  Map<String, dynamic>? pokemonData;
  bool isLoading = false;

  Future<void> fetchPokemon() async {
    if (pokemonName.isEmpty) return;

    setState(() {
      isLoading = true;
    });

    final response = await http.get(
      Uri.parse('https://pokeapi.co/api/v2/pokemon/$pokemonName'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        pokemonData = data;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to load Pokémon data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buscar Pokémon'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Ingresa el nombre de un Pokémon',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  pokemonName = value.toLowerCase();
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: fetchPokemon,
              child: Text('Buscar Pokémon'),
            ),
            SizedBox(height: 20),
            isLoading
                ? CircularProgressIndicator()
                : pokemonData == null
                    ? Text('No se ha buscado ningún Pokémon')
                    : Column(
                        children: [
                          Image.network(
                            pokemonData!['sprites']['front_default'],
                            width: 150,
                            height: 150,),
                          SizedBox(height: 20),
                          Text(
                            'Nombre: ${pokemonData!['name']}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),
                          ),
                          SizedBox(height: 20),
                          Text('Experiencia base: ${pokemonData!['base_experience']}', style: TextStyle(fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text('Habilidades:',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),
                          ),
                          Column(
                            children: (pokemonData!['abilities'] as List).map((ability) => Text('- ${ability['ability']['name']}'
                            ,style: TextStyle(fontSize: 16,))).toList(),
                          ),
                        ],
                      ),
          ],
        ),
      ),
    );
  }
}