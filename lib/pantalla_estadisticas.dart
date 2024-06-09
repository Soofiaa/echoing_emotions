import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'GEStion_estadísticas.dart';

class EstadisticasEmojis extends StatelessWidget {
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
            Text(
              'Estadísticas de Emociones',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            _buildEmotionStat('😊', 'Alegría', emotionStatistics),
            _buildEmotionStat('😢', 'Tristeza', emotionStatistics),
            _buildEmotionStat('😠', 'Ira', emotionStatistics),
            _buildEmotionStat('😨', 'Miedo', emotionStatistics),
            _buildEmotionStat('😲', 'Sorpresa', emotionStatistics),
            _buildEmotionStat('😒', 'Desagrado', emotionStatistics),
            _buildEmotionStat('😳', 'Vergüenza', emotionStatistics),
            _buildEmotionStat('😮', 'Asombro', emotionStatistics),
          ],
        ),
      ),
    );
  }

  Widget _buildEmotionStat(String emoji, String emotion, EmotionStatistics statistics) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$emoji $emotion',
          style: TextStyle(fontSize: 18),
        ),
        Text(
          statistics.getEmotionCount(emoji).toString(),
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
