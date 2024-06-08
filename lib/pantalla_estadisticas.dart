import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'GEStion_estadísticas.dart';

class EstadisticasEmojis extends StatefulWidget {
  @override
  _EstadisticasEmojisState createState() => _EstadisticasEmojisState();
}

class _EstadisticasEmojisState extends State<EstadisticasEmojis> {
  String _selectedPeriod = 'Diario';
  final List<Map<String, String>> emociones = [
    {'emoji': '😨', 'name': 'Miedo'},
    {'emoji': '😢', 'name': 'Tristeza'},
    {'emoji': '😠', 'name': 'Ira'},
    {'emoji': '😊', 'name': 'Alegría'},
    {'emoji': '😲', 'name': 'Sorpresa'},
    {'emoji': '😒', 'name': 'Desagrado'},
    {'emoji': '😳', 'name': 'Vergüenza'},
    {'emoji': '😮', 'name': 'Asombro'},
  ];

  @override
  Widget build(BuildContext context) {
    final statistics = Provider.of<EmotionStatistics>(context).emotionCount;

    return Scaffold(
      appBar: AppBar(
        title: Text('Estadísticas de Emojis'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String result) {
              setState(() {
                _selectedPeriod = result;
              });
            },
            itemBuilder: (BuildContext context) {
              return ['Diario', 'Semanal', 'Mensual', 'Anual'].map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: ListView(
        children: emociones.map((emocion) {
          String emoji = emocion['emoji']!;
          String name = emocion['name']!;
          int count = statistics[emoji] ?? 0;
          return ListTile(
            title: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '$emoji ',
                    style: TextStyle(
                      fontSize: 32.0, // Aumenta este valor para hacer el emoji más grande
                      height: 1.2, // Ajusta la altura de la línea si es necesario
                    ),
                  ),
                  TextSpan(
                    text: '$name = $count vec${count != 1 ? 'es' : ''}',
                    style: TextStyle(
                      fontSize: 18.0, // Tamaño de la fuente para el texto
                      color: Colors.black, // Color del texto
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),

    );
  }
}
