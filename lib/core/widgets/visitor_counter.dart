// lib/core/widgets/visitor_counter.dart
import 'package:flutter/material.dart';

class VisitorCounter extends StatefulWidget {
  const VisitorCounter({super.key});

  @override
  State<VisitorCounter> createState() => _VisitorCounterState();
}

class _VisitorCounterState extends State<VisitorCounter> {
  int _visitorCount = 0;

  @override
  void initState() {
    super.initState();
    _simulateVisitorCount();
  }

  void _simulateVisitorCount() {
    // Simulate visitor count
    _visitorCount = 1254;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 80,
      left: 24,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.7),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFF06B6D4).withOpacity(0.3),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              '👁️',
              style: TextStyle(fontSize: 12),
            ),
            const SizedBox(width: 4),
            Text(
              '$_visitorCount',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 4),
            const Text(
              'visitors online',
              style: TextStyle(
                color: Colors.white60,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}