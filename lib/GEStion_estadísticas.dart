// lib/emotion_statistics.dart
import 'package:flutter/foundation.dart';

class EmotionStatistics with ChangeNotifier {
  final Map<String, int> _emotionCount = {
    '😨': 0,
    '😢': 0,
    '😠': 0,
    '😊': 0,
    '😲': 0,
    '😒': 0,
    '😳': 0,
    '😮': 0,
  };

  Map<String, int> get emotionCount => _emotionCount;

  void incrementEmotion(String emoji) {
    if (_emotionCount.containsKey(emoji)) {
      _emotionCount[emoji] = (_emotionCount[emoji] ?? 0) + 1;
      notifyListeners();
    }
  }
}
