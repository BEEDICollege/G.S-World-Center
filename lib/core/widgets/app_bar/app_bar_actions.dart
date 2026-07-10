// lib/core/widgets/app_bar/app_bar_actions.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';

class AppBarActions extends StatelessWidget {
  const AppBarActions({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Theme Toggle
            _buildThemeToggle(),
            const SizedBox(width: 4),
            
            // Action Buttons - Desktop only
            if (!isMobile) ...[
              _buildActionButton('Resume', Icons.download, () {}),
              const SizedBox(width: 4),
              _buildActionButton('Hire Me', Icons.work_outline, () {}),
              const SizedBox(width: 4),
            ],
            
            // Social Icons - Desktop only
            if (!isMobile) ...[
              _buildSocialIcon(Icons.code, 'GitHub'),
              _buildSocialIcon(Icons.work, 'LinkedIn'),
              _buildSocialIcon(Icons.camera_alt, 'Instagram'),
            ],
          ],
        );
      },
    );
  }

  Widget _buildSocialIcon(IconData icon, String label) {
    return IconButton(
      icon: Icon(icon, size: 18, color: Colors.white70),
      onPressed: () {},
      tooltip: label,
      splashRadius: 20,
      padding: const EdgeInsets.all(4),
      constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
    );
  }

  Widget _buildThemeToggle() {
    return Consumer<ThemeProvider>(
      builder: (context, provider, _) {
        return IconButton(
          icon: Icon(
            provider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            size: 20,
            color: Colors.white70,
          ),
          onPressed: provider.toggleTheme,
          splashRadius: 20,
          padding: const EdgeInsets.all(4),
          constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
        );
      },
    );
  }

  Widget _buildActionButton(String label, IconData icon, VoidCallback onTap) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF06B6D4), Color(0xFF10B981)],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF06B6D4).withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: Colors.white),
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}