// lib/core/widgets/app_bar/app_bar_widget.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/scroll_provider.dart';
import 'app_bar_menu.dart';
import 'app_bar_logo.dart';
import 'app_bar_actions.dart';

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({super.key});

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  bool _isScrolled = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<ScrollProvider>(
      builder: (context, scrollProvider, _) {
        final isScrolled = scrollProvider.scrollPosition > 50;
        if (isScrolled != _isScrolled) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() => _isScrolled = isScrolled);
          });
        }
        
        return LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 800;
            
            return Container(
              height: 80,
              decoration: BoxDecoration(
                gradient: _isScrolled
                    ? const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF0A1628),
                          Color(0xFF0D2B3E),
                        ],
                      )
                    : const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF06B6D4), // Cyan
                          Color(0xFF10B981), // Green
                          Color(0xFF0D2B3E), // Dark Blue-Green
                        ],
                      ),
                boxShadow: _isScrolled
                    ? [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    if (isMobile) _buildMenuButton(context),
                    if (isMobile) const SizedBox(width: 8),
                    const AppBarLogo(),
                    const SizedBox(width: 40),
                    if (!isMobile) const Expanded(child: AppBarMenu()),
                    const Spacer(),
                    const AppBarActions(),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildMenuButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.menu, color: Colors.white, size: 28),
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
      tooltip: 'Menu',
      splashRadius: 24,
    );
  }
}