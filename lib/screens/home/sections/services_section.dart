// lib/screens/home/sections/services_section.dart
import 'package:flutter/material.dart';

class ServicesSection extends StatelessWidget {
   ServicesSection({super.key});

  final List<Map<String, dynamic>> services = [
    const {'name': 'Flutter App Development', 'icon': Icons.phone_android, 'desc': 'Build beautiful cross-platform mobile apps with Flutter'},
    const {'name': 'Android App Development', 'icon': Icons.android, 'desc': 'Native Android apps with Kotlin and Java'},
    const {'name': 'iOS App Development', 'icon': Icons.apple, 'desc': 'Native iOS apps with Swift and Objective-C'},
    const {'name': 'Web Development', 'icon': Icons.web, 'desc': 'Modern web applications with React and Next.js'},
    const {'name': 'Backend Development', 'icon': Icons.storage, 'desc': 'Scalable backend systems with FastAPI and Node.js'},
    const {'name': 'Desktop Software', 'icon': Icons.desktop_windows, 'desc': 'Cross-platform desktop applications'},
    const {'name': 'AI Integration', 'icon': Icons.psychology, 'desc': 'Intelligent AI and machine learning integration'},
    const {'name': 'REST API Development', 'icon': Icons.api, 'desc': 'Robust REST API development and integration'},
    const {'name': 'Firebase Integration', 'icon': Icons.fireplace, 'desc': 'Firebase authentication, database, and cloud functions'},
    const {'name': 'UI/UX Design', 'icon': Icons.design_services, 'desc': 'Premium UI/UX design with Figma and Adobe XD'},
    const {'name': 'Cloud Deployment', 'icon': Icons.cloud, 'desc': 'Cloud deployment on AWS, GCP, and Azure'},
    {'name': 'Database Design', 'icon': Icons.table_chart, 'desc': 'Efficient database design with SQL and NoSQL'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'My Services',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'What I can do for you',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white60,
            ),
          ),
          const SizedBox(height: 30),
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth < 600 ? 1 : constraints.maxWidth < 900 ? 2 : 3;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: 1.4,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: services.length,
                itemBuilder: (context, index) {
                  return _buildServiceCard(services[index]);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(Map<String, dynamic> service) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        padding: const EdgeInsets.all(20),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF2563EB), Color(0xFF7C3AED)],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(service['icon'], color: Colors.white, size: 24),
            ),
            const SizedBox(height: 12),
            Text(
              service['name'],
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              service['desc'],
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white60,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Text(
              'Read More →',
              style: TextStyle(
                fontSize: 12,
                color: const Color(0xFF2563EB),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}