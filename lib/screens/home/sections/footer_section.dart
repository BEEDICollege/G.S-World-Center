// lib/screens/home/sections/footer_section.dart
import 'package:flutter/material.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.black.withOpacity(0.3),
          ],
        ),
      ),
      child: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 600;
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: isMobile ? 1 : 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'GS World Center',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Building premium digital experiences with cutting-edge technology. Let\'s create something amazing together.',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white60,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            _buildSocialIcon(Icons.code),
                            const SizedBox(width: 8),
                            _buildSocialIcon(Icons.work),
                            const SizedBox(width: 8),
                            _buildSocialIcon(Icons.camera_alt),
                            const SizedBox(width: 8),
                            _buildSocialIcon(Icons.video_library),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (!isMobile) ...[
                    Expanded(
                      flex: 1,
                      child: _buildFooterLinks('Quick Links', [
                        'Home',
                        'About',
                        'Services',
                        'Projects',
                        'Contact',
                      ]),
                    ),
                    Expanded(
                      flex: 1,
                      child: _buildFooterLinks('Services', [
                        'Flutter Development',
                        'Web Development',
                        'AI Integration',
                        'UI/UX Design',
                        'Cloud Deployment',
                      ]),
                    ),
                  ],
                ],
              );
            },
          ),
          const SizedBox(height: 30),
          Container(
            height: 1,
            color: Colors.white10,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '© 2024 GS World Center. All rights reserved.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white54,
                ),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Privacy Policy',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white54,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Terms',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white54,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.arrow_upward,
                      color: Colors.white54,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: Colors.white54, size: 20),
    );
  }

  Widget _buildFooterLinks(String title, List<String> links) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ...links.map((link) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              link,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white54,
              ),
            ),
          );
        }).toList(),
      ],
    );
  }
}