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
      backgroundColor: const Color(0xFF0A1628),
      width: 280,
      elevation: 20,
      shadowColor: Colors.black54,
      child: SafeArea(
        child: Column(
          children: [
            // Drawer Header with Logo
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF06B6D4),
                    Color(0xFF10B981),
                    Color(0xFF0D2B3E),
                  ],
                ),
              ),
              child: Row(
                children: [
                  // Logo
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 17, 5, 230),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.asset(
                        'assets/logos/logo.png',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.white,
                            child: const Center(
                              child: Text(
                                'G.S',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF06B6D4),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  // Company Info
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'G.S World Center',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Premium Software Solutions',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Close Button
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 20,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(minWidth: 30, minHeight: 30),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                children: [
                  _buildDrawerItem(
                    context,
                    'Home',
                    Icons.home_outlined,
                    '/home',
                    true,
                  ),
                  _buildDivider(),
                  _buildDrawerItem(
                    context,
                    'About',
                    Icons.person_outline,
                    '/about',
                    false,
                  ),
                  _buildDivider(),
                  _buildDrawerItem(
                    context,
                    'Skills',
                    Icons.code_outlined,
                    '/skills',
                    false,
                  ),
                  _buildDivider(),
                  _buildDrawerItem(
                    context,
                    'Services',
                    Icons.work_outline,
                    '/services',
                    false,
                  ),
                  _buildDivider(),
                  _buildDrawerItem(
                    context,
                    'Projects',
                    Icons.grid_view_outlined,
                    '/projects',
                    false,
                  ),
                  _buildDivider(),
                  _buildDrawerItem(
                    context,
                    'Experience',
                    Icons.timeline_outlined,
                    '/experience',
                    false,
                  ),
                  _buildDivider(),
                  _buildDrawerItem(
                    context,
                    'Education',
                    Icons.school_outlined,
                    '/education',
                    false,
                  ),
                  _buildDivider(),
                  _buildDrawerItem(
                    context,
                    'Certificates',
                    Icons.verified_outlined,
                    '/certificates',
                    false,
                  ),
                  _buildDivider(),
                  _buildDrawerItem(
                    context,
                    'Testimonials',
                    Icons.rate_review_outlined,
                    '/testimonials',
                    false,
                  ),
                  _buildDivider(),
                  _buildDrawerItem(
                    context,
                    'Gallery',
                    Icons.photo_library_outlined,
                    '/gallery',
                    false,
                  ),
                  _buildDivider(),
                  _buildDrawerItem(
                    context,
                    'Blog',
                    Icons.article_outlined,
                    '/blog',
                    false,
                  ),
                  _buildDivider(),
                  _buildDrawerItem(
                    context,
                    'Contact',
                    Icons.contact_mail_outlined,
                    '/contact',
                    false,
                  ),
                  _buildDivider(),
                  // Social Media Section
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Connect With Me',
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            _buildSocialIcon(Icons.code, 'GitHub'),
                            const SizedBox(width: 6),
                            _buildSocialIcon(Icons.work, 'LinkedIn'),
                            const SizedBox(width: 6),
                            _buildSocialIcon(Icons.camera_alt, 'Instagram'),
                            const SizedBox(width: 6),
                            _buildSocialIcon(Icons.video_library, 'YouTube'),
                            const SizedBox(width: 6),
                            _buildSocialIcon(Icons.chat, 'WhatsApp'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Divider(color: Colors.white10, height: 1),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildDrawerButton(
                            '📄 Resume',
                            Icons.download,
                            () {},
                            isPrimary: false,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildDrawerButton(
                            '💼 Hire Me',
                            Icons.work,
                            () {},
                            isPrimary: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
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
    bool isActive,
  ) {
    return ListTile(
      leading: Icon(
        icon,
        color: isActive ? const Color(0xFF06B6D4) : Colors.white60,
        size: 22,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isActive ? const Color(0xFF06B6D4) : Colors.white70,
          fontSize: 14,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
      trailing: isActive
          ? Container(
              width: 4,
              height: 20,
              decoration: BoxDecoration(
                color: const Color(0xFF06B6D4),
                borderRadius: BorderRadius.circular(2),
              ),
            )
          : const SizedBox.shrink(),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, route);
      },
      hoverColor: Colors.white10,
      splashColor: Colors.white10,
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      color: Colors.white10,
      height: 1,
      indent: 12,
      endIndent: 12,
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
        size: 18,
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
      height: 38,
      decoration: BoxDecoration(
        gradient: isPrimary
            ? const LinearGradient(
                colors: [Color(0xFF06B6D4), Color(0xFF10B981)],
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
                color: isPrimary ? const Color.fromARGB(255, 5, 104, 234) : Colors.white70,
                size: 14,
              ),
              const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                  color: isPrimary ? const Color.fromARGB(255, 5, 126, 219) : Colors.white70,
                  fontSize: 11,
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