import 'package:flutter/material.dart';

class EmotionStatistics extends ChangeNotifier {
  final Map<String, int> _emotionCounts = {};

  void incrementEmotion(String emotion) {
    if (_emotionCounts.containsKey(emotion)) {
      _emotionCounts[emotion] = _emotionCounts[emotion]! + 1;
    } else {
      _emotionCounts[emotion] = 1;
    }
    notifyListeners();
  }

  int getEmotionCount(String emotion) {
    return _emotionCounts[emotion] ?? 0;
  }
}
