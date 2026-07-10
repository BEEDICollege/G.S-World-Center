// lib/screens/home/sections/stats_overview.dart
import 'package:flutter/material.dart';

class StatsOverview extends StatelessWidget {
  const StatsOverview({super.key});

  final List<Map<String, dynamic>> stats = const [
    {'icon': Icons.code, 'label': 'Projects', 'value': '100+', 'color': Color(0xFF06B6D4)},
    {'icon': Icons.people, 'label': 'Clients', 'value': '50+', 'color': Color(0xFF10B981)},
    {'icon': Icons.star, 'label': 'Reviews', 'value': '4.9', 'color': Color(0xFFFFD700)},
    {'icon': Icons.emoji_events, 'label': 'Awards', 'value': '12', 'color': Color(0xFFFF6B00)},
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        final crossAxisCount = isMobile ? 2 : 4;
        
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: 1.2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: stats.length,
            itemBuilder: (context, index) {
              return _buildStatCard(stats[index], index);
            },
          ),
        );
      },
    );
  }

  Widget _buildStatCard(Map<String, dynamic> stat, int index) {
    final delay = index * 0.1;
    
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOut,
      tween: Tween<double>(begin: 0, end: 1),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              stat['color'].withOpacity(0.15),
              stat['color'].withOpacity(0.05),
            ],
          ),
          border: Border.all(
            color: stat['color'].withOpacity(0.2),
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: stat['color'].withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              stat['icon'],
              color: stat['color'],
              size: 28,
            ),
            const SizedBox(height: 6),
            Text(
              stat['value'],
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: stat['color'],
              ),
            ),
            const SizedBox(height: 2),
            Text(
              stat['label'],
              style: const TextStyle(
                fontSize: 11,
                color: Colors.white60,
              ),
            ),
          ],
        ),
      ),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
    );
  }
}