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
              height: 70,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                gradient: _isScrolled
                    ? const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF0A0E27),
                          Color(0xFF0D2137),
                        ],
                      )
                    : const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF0A0E27),
                          Color(0xFF1A1040),
                          Color(0xFF0D2137),
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
                border: Border(
                  bottom: BorderSide(
                    color: Colors.white.withOpacity(_isScrolled ? 0.05 : 0),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  // Menu Button - Mobile
                  if (isMobile) ...[
                    _buildMenuButton(context),
                    const SizedBox(width: 8),
                  ],
                  
                  // Logo
                  const AppBarLogo(),
                  
                  const SizedBox(width: 20),
                  
                  // Navigation Menu - Desktop
                  if (!isMobile) ...[
                    const Expanded(child: AppBarMenu()),
                    const SizedBox(width: 20),
                  ],
                  
                  const Spacer(),
                  
                  // Actions
                  const AppBarActions(),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildMenuButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        icon: const Icon(Icons.menu, color: Colors.white, size: 24),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
        tooltip: 'Menu',
        splashRadius: 24,
        padding: const EdgeInsets.all(8),
        constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
      ),
    );
  }
}