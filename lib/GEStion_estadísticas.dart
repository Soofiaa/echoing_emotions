import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class EmotionStatistics extends ChangeNotifier {
  final Map<String, int> _emotionCounts = {};
  final Map<String, List<DateTime>> _emotionTimestamps = {};

  void incrementEmotion(String emotion) {
    final now = DateTime.now();
    if (_emotionCounts.containsKey(emotion)) {
      _emotionCounts[emotion] = _emotionCounts[emotion]! + 1;
      _emotionTimestamps[emotion]!.add(now);
    } else {
      _emotionCounts[emotion] = 1;
      _emotionTimestamps[emotion] = [now];
    }
    notifyListeners();
  }

  int getEmotionCount(String emotion) {
    return _emotionCounts[emotion] ?? 0;
  }

  Map<String, int> getEmotionsByPeriod(String period) {
    DateTime now = DateTime.now();
    DateTime startPeriod;

    switch (period) {
      case 'diario':
        startPeriod = DateTime(now.year, now.month, now.day);
        break;
      case 'semanal':
        startPeriod = now.subtract(Duration(days: now.weekday - 1));
        break;
      case 'mensual':
        startPeriod = DateTime(now.year, now.month);
        break;
      case 'anual':
        startPeriod = DateTime(now.year);
        break;
      default:
        startPeriod = now;
    }

    Map<String, int> filteredEmotions = {};
    _emotionTimestamps.forEach((emotion, timestamps) {
      int count = timestamps.where((timestamp) => timestamp.isAfter(startPeriod)).length;
      if (count > 0) {
        filteredEmotions[emotion] = count;
      }
    });

    return filteredEmotions;
  }
}
