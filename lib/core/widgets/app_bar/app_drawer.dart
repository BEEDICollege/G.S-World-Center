// lib/core/widgets/app_bar/app_drawer.dart
import 'package:flutter/material.dart';
import '../../../screens/about/about_screen.dart';
import '../../../screens/skills/skills_screen.dart';
import '../../../screens/projects/projects_screen.dart';
import '../../../screens/experience/experience_screen.dart';
import '../../../screens/education/education_screen.dart';
import '../../../screens/certificates/certificates_screen.dart';
import '../../../screens/testimonials/testimonials_screen.dart';
import '../../../screens/gallery/gallery_screen.dart';
import '../../../screens/blog/blog_screen.dart';
import '../../../screens/contact/contact_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF1A1A2E),
      width: 300,
      child: SafeArea(
        child: Column(
          children: [
            // Drawer Header with Logo
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF2563EB),
                    Color(0xFF7C3AED),
                    Color(0xFF06B6D4),
                    Color(0xFFEC4899),
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo with border
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/logos/logo.jpeg',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          // Fallback if image doesn't load
                          return Container(
                            color: Colors.white,
                            child: const Center(
                              child: Text(
                                'GS',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2563EB),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'GS World Center',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Premium Software Solutions',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildDrawerItem(
                    context,
                    'Home',
                    Icons.home_outlined,
                    '/home',
                  ),
                  _buildDivider(),
                  _buildDrawerItem(
                    context,
                    'About',
                    Icons.person_outline,
                    '/about',
                  ),
                  _buildDivider(),
                  _buildDrawerItem(
                    context,
                    'Skills',
                    Icons.code_outlined,
                    '/skills',
                  ),
                  _buildDivider(),
                  _buildDrawerItem(
                    context,
                    'Services',
                    Icons.work_outline,
                    '/services',
                  ),
                  _buildDivider(),
                  _buildDrawerItem(
                    context,
                    'Projects',
                    Icons.grid_view_outlined,
                    '/projects',
                  ),
                  _buildDivider(),
                  _buildDrawerItem(
                    context,
                    'Experience',
                    Icons.timeline_outlined,
                    '/experience',
                  ),
                  _buildDivider(),
                  _buildDrawerItem(
                    context,
                    'Education',
                    Icons.school_outlined,
                    '/education',
                  ),
                  _buildDivider(),
                  _buildDrawerItem(
                    context,
                    'Certificates',
                    Icons.verified_outlined,
                    '/certificates',
                  ),
                  _buildDivider(),
                  _buildDrawerItem(
                    context,
                    'Testimonials',
                    Icons.rate_review_outlined,
                    '/testimonials',
                  ),
                  _buildDivider(),
                  _buildDrawerItem(
                    context,
                    'Gallery',
                    Icons.photo_library_outlined,
                    '/gallery',
                  ),
                  _buildDivider(),
                  _buildDrawerItem(
                    context,
                    'Blog',
                    Icons.article_outlined,
                    '/blog',
                  ),
                  _buildDivider(),
                  _buildDrawerItem(
                    context,
                    'Contact',
                    Icons.contact_mail_outlined,
                    '/contact',
                  ),
                  _buildDivider(),
                  // Social Media Section
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Connect With Me',
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            _buildSocialIcon(Icons.code, 'GitHub'),
                            const SizedBox(width: 8),
                            _buildSocialIcon(Icons.work, 'LinkedIn'),
                            const SizedBox(width: 8),
                            _buildSocialIcon(Icons.camera_alt, 'Instagram'),
                            const SizedBox(width: 8),
                            _buildSocialIcon(Icons.video_library, 'YouTube'),
                            const SizedBox(width: 8),
                            _buildSocialIcon(Icons.chat, 'WhatsApp'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Divider(color: Colors.white10),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: _buildDrawerButton(
                            'Resume',
                            Icons.download,
                            () {},
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildDrawerButton(
                            'Hire Me',
                            Icons.work,
                            () {},
                            isPrimary: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context,
    String title,
    IconData icon,
    String route,
  ) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.white70,
        size: 22,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: Colors.white30,
        size: 20,
      ),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, route);
      },
      hoverColor: Colors.white10,
      splashColor: Colors.white10,
    );
  }

  Widget _buildDivider() {
    return const Divider(
      color: Colors.white10,
      height: 1,
      indent: 16,
      endIndent: 16,
    );
  }

  Widget _buildSocialIcon(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        icon,
        color: Colors.white60,
        size: 20,
      ),
    );
  }

  Widget _buildDrawerButton(
    String label,
    IconData icon,
    VoidCallback onTap, {
    bool isPrimary = false,
  }) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        gradient: isPrimary
            ? const LinearGradient(
                colors: [Color(0xFF2563EB), Color(0xFF7C3AED)],
              )
            : null,
        border: isPrimary
            ? null
            : Border.all(
                color: Colors.white24,
              ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isPrimary ? Colors.white : Colors.white70,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                  color: isPrimary ? Colors.white : Colors.white70,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}