// lib/screens/home/sections/blog_section.dart
import 'package:flutter/material.dart';

class BlogSection extends StatelessWidget {
  const BlogSection({super.key});

  final List<Map<String, dynamic>> blogs = const [
    {
      'title': 'Flutter vs React Native',
      'date': 'Dec 15, 2024',
      'excerpt': 'A comprehensive comparison of two popular frameworks',
    },
    {
      'title': 'Building with FastAPI',
      'date': 'Dec 10, 2024',
      'excerpt': 'Best practices for building scalable APIs',
    },
    {
      'title': 'AI in Mobile Apps',
      'date': 'Dec 5, 2024',
      'excerpt': 'Integrating artificial intelligence into mobile applications',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Blog',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Latest articles and insights',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white60,
            ),
          ),
          const SizedBox(height: 30),
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth < 600 ? 1 : 3;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: 1.4,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: blogs.length,
                itemBuilder: (context, index) {
                  return _buildBlogCard(blogs[index]);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBlogCard(Map<String, dynamic> blog) {
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
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Icon(
                  Icons.article_outlined,
                  color: Colors.white24,
                  size: 30,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              blog['title'],
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              blog['excerpt'],
              style: const TextStyle(
                fontSize: 13,
                color: Colors.white60,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Text(
              blog['date'],
              style: const TextStyle(
                fontSize: 11,
                color: Colors.white30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}