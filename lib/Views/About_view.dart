import 'package:flutter/material.dart';

class AboutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acerca de Mí'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Tu foto
            CircleAvatar(
              backgroundImage: AssetImage('assets/Andy Foto.jpg'), // Ruta de tu foto
              radius: 60,
            ),
            SizedBox(height: 20),
            // Tu nombre
            Text(
              'Soy Andy Rodriguez',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            // Breve descripción
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Soy un desarrollador Flutter apasionado por crear aplicaciones móviles increíbles. ¡Contáctame para colaborar en proyectos emocionantes!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 20),
            // Datos de contacto
            ListTile(
              leading: Icon(Icons.email),
              title: Text('20230972@itla.edu.do'),
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('+1 234 567 890'),
            ),
            ListTile(
              leading: Icon(Icons.link),
              title: Text('https://tusitio.com'),
            ),
          ],
        ),
      ),
    );
  }
}