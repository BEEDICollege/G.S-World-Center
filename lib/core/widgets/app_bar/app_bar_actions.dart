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
            if (!isMobile) ...[
              _buildSocialIcon(Icons.code, 'GitHub'),
              _buildSocialIcon(Icons.work, 'LinkedIn'),
              _buildSocialIcon(Icons.camera_alt, 'Instagram'),
              const SizedBox(width: 8),
            ],
            _buildThemeToggle(),
            const SizedBox(width: 8),
            if (!isMobile) ...[
              _buildActionButton('Resume', Icons.download, () {}),
              const SizedBox(width: 4),
              _buildActionButton('Hire Me', Icons.work_outline, () {}),
            ],
            // REMOVED: The menu button from here - it's now in the app bar
          ],
        );
      },
    );
  }

  Widget _buildSocialIcon(IconData icon, String label) {
    return IconButton(
      icon: Icon(icon, size: 20, color: Colors.white70),
      onPressed: () {},
      tooltip: label,
      splashRadius: 20,
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
        );
      },
    );
  }

  Widget _buildActionButton(String label, IconData icon, VoidCallback onTap) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF2563EB), Color(0xFF7C3AED)],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: Colors.white),
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}