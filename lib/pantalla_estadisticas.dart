import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'GEStion_estadísticas.dart';

class EstadisticasEmojis extends StatefulWidget {
  @override
  _EstadisticasEmojisState createState() => _EstadisticasEmojisState();
}

class _EstadisticasEmojisState extends State<EstadisticasEmojis> {
  String _selectedPeriod = 'diario';

  @override
  Widget build(BuildContext context) {
    final emotionStatistics = Provider.of<EmotionStatistics>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Estadísticas de Emociones'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              value: _selectedPeriod,
              icon: Icon(Icons.arrow_downward, color: Colors.teal),
              iconSize: 24,
              elevation: 16,
              dropdownColor: Colors.white,
              style: TextStyle(color: Colors.teal),
              underline: Container(
                height: 2,
                color: Colors.teal,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedPeriod = newValue!;
                });
              },
              items: <String>['diario', 'semanal', 'mensual', 'anual']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {});
              },
              child: Text('Filtrar'),
            ),
            SizedBox(height: 20),
            _buildEmotionStats(emotionStatistics.getEmotionsByPeriod(_selectedPeriod)),
          ],
        ),
      ),
    );
  }

  Widget _buildEmotionStats(Map<String, int> emotions) {
    return Column(
      children: emotions.entries.map((entry) {
        return _buildEmotionStat(entry.key, entry.value);
      }).toList(),
    );
  }

  Widget _buildEmotionStat(String emoji, int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          emoji,
          style: TextStyle(fontSize: 20),
        ),
        Text(
          count.toString(),
          style: TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}