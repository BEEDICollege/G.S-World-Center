// lib/core/providers/scroll_provider.dart
import 'package:flutter/material.dart';

class ScrollProvider extends ChangeNotifier {
  double _scrollPosition = 0;
  double _maxScroll = 1000;

  double get scrollPosition => _scrollPosition;
  double get scrollProgress => _maxScroll > 0 ? _scrollPosition / _maxScroll : 0;

  void updateScrollPosition(double position) {
    _scrollPosition = position;
    notifyListeners();
  }

  void updateMaxScroll(double max) {
    _maxScroll = max;
    notifyListeners();
  }
}