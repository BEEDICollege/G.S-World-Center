// lib/screens/home/sections/skills_section.dart
import 'package:flutter/material.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  final List<Map<String, dynamic>> skills = const [
    {'name': 'Flutter', 'icon': 'assets/logos/flutter.png', 'percentage': 95},
    {'name': 'Dart', 'icon': 'assets/logos/dart.png', 'percentage': 90},
    {'name': 'Python', 'icon': 'assets/logos/python.png', 'percentage': 85},
    {'name': 'FastAPI', 'icon': 'assets/logos/fastapi.png', 'percentage': 80},
    {'name': 'Firebase', 'icon': 'assets/logos/firebase.png', 'percentage': 85},
    {'name': 'NodeJS', 'icon': 'assets/logos/nodejs.png', 'percentage': 75},
    {'name': 'JavaScript', 'icon': 'assets/logos/javascript.png', 'percentage': 80},
    {'name': 'HTML/CSS', 'icon': 'assets/logos/html.png', 'percentage': 85},
    {'name': 'SQL', 'icon': 'assets/logos/sql.png', 'percentage': 75},
    {'name': 'Git', 'icon': 'assets/logos/git.png', 'percentage': 80},
    {'name': 'REST API', 'icon': 'assets/logos/rest.png', 'percentage': 85},
    {'name': 'AI/ML', 'icon': 'assets/logos/ai.png', 'percentage': 70},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'My Skills',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Technologies I work with',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white60,
            ),
          ),
          const SizedBox(height: 30),
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth < 600 ? 2 : 4;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: 1.2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: skills.length,
                itemBuilder: (context, index) {
                  return _buildSkillCard(skills[index], index);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSkillCard(Map<String, dynamic> skill, int index) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withOpacity(0.05),
              Colors.white.withOpacity(0.02),
            ],
          ),
          border: Border.all(
            color: Colors.white.withOpacity(0.1),
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.02),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  skill['name'].substring(0, 2),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.cyan,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              skill['name'],
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${skill['percentage']}%',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white60,
              ),
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: skill['percentage'] / 100,
                minHeight: 4,
                backgroundColor: Colors.white10,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFF2563EB),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}