// lib/core/widgets/scroll_progress_indicator.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/scroll_provider.dart';

class ScrollProgressIndicator extends StatelessWidget {
  const ScrollProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ScrollProvider>(
      builder: (context, provider, _) {
        return Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: LinearProgressIndicator(
            value: provider.scrollProgress,
            minHeight: 2,
            backgroundColor: Colors.transparent,
            valueColor: const AlwaysStoppedAnimation<Color>(
              Color(0xFF2563EB),
            ),
          ),
        );
      },
    );
  }
}