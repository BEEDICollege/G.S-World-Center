// lib/core/widgets/scrolling_news_bar.dart
import 'package:flutter/material.dart';

class ScrollingNewsBar extends StatefulWidget {
  const ScrollingNewsBar({super.key});

  @override
  State<ScrollingNewsBar> createState() => _ScrollingNewsBarState();
}

class _ScrollingNewsBarState extends State<ScrollingNewsBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<String> news = [
    '🚀 Flutter Developer',
    '🚀 FastAPI Expert',
    '🚀 AI Developer',
    '🚀 Mobile App Developer',
    '🚀 Available For Freelance',
    '🚀 Open Source Contributor',
    '🚀 GS World Center',
    '🚀 Premium Flutter Developer',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      color: Colors.black.withOpacity(0.3),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF2563EB), Color(0xFF7C3AED)],
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'NEWS',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: _buildScrollingText(),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildScrollingText() {
    final index = (_controller.value * news.length).floor() % news.length;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const Icon(Icons.bolt, color: Colors.cyan, size: 14),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              news[index],
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}