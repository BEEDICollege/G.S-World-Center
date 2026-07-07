// lib/core/widgets/floating_contact_buttons.dart
import 'package:flutter/material.dart';

class FloatingContactButtons extends StatelessWidget {
  const FloatingContactButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 80,
      right: 24,
      child: Column(
        children: [
          _buildFloatingButton(Icons.message, Colors.green),
          const SizedBox(height: 8),
          _buildFloatingButton(Icons.chat, Colors.blue),
          const SizedBox(height: 8),
          _buildFloatingButton(Icons.phone, Colors.orange),
        ],
      ),
    );
  }

  Widget _buildFloatingButton(IconData icon, Color color) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 20,
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white, size: 24),
        onPressed: () {},
      ),
    );
  }
}