import 'package:flutter/material.dart';
import 'Genero.dart';
import 'Edad.dart';
import 'university_view.dart';
import 'weather_view.dart';
import 'PokemonView.dart'; // Importa la nueva vista
import 'news_view.dart';
import 'About_view.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Toolbox App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Image.asset('assets/toolbox.png', width: 200, height: 200),
            SizedBox(height: 10),
            ElevatedButton(onPressed: () {Navigator.push(
                  context,MaterialPageRoute(builder: (context) => GenderView()),
                );
              },
              child: Text('Predecir Género'),
            ),
            SizedBox(height: 10),ElevatedButton(onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => AgeView()),
                );
              },
              child: Text('Predecir Edad'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,MaterialPageRoute(builder: (context) => UniversityView()),
                );
              },
              child: Text('Buscar Universidades'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context) => WeatherView()),);
              },
              child: Text('Ver Clima'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => PokemonView()),);
              },
              child: Text('Buscar Pokémon'),
              ),
              SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NewsView()),
                );
              },
              child: Text('Últimas Noticias'),
              ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AboutView()),
                );
              },
              child: Text('Acerca de Mí'))
            
          ],
        ),
      ),
    );
  }
}