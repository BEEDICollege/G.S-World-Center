// lib/core/widgets/app_bar/app_bar_menu.dart
import 'package:flutter/material.dart';

class AppBarMenu extends StatelessWidget {
  const AppBarMenu({super.key});

  final List<Map<String, String>> menuItems = const [
    {'label': 'Home', 'anchor': 'home'},
    {'label': 'About', 'anchor': 'about'},
    {'label': 'Skills', 'anchor': 'skills'},
    {'label': 'Services', 'anchor': 'services'},
    {'label': 'Projects', 'anchor': 'projects'},
    {'label': 'Experience', 'anchor': 'experience'},
    {'label': 'Education', 'anchor': 'education'},
    {'label': 'Certificates', 'anchor': 'certificates'},
    {'label': 'Testimonials', 'anchor': 'testimonials'},
    {'label': 'Gallery', 'anchor': 'gallery'},
    {'label': 'Blog', 'anchor': 'blog'},
    {'label': 'Contact', 'anchor': 'contact'},
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Hide menu on mobile (width < 800)
        if (constraints.maxWidth < 800) {
          return const SizedBox.shrink();
        }
        
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: menuItems.map((item) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      // Scroll to section
                    },
                    child: Text(
                      item['label']!,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}