// lib/core/widgets/floating_contact_buttons.dart
import 'package:flutter/material.dart';

class FloatingContactButtons extends StatelessWidget {
  const FloatingContactButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 160,
      right: 24,
      child: Column(
        children: [
          _buildFloatingButton(
            Icons.message_rounded,
            const Color(0xFF25D366),
            'WhatsApp',
            'https://wa.me/919876543210',
          ),
          const SizedBox(height: 8),
          _buildFloatingButton(
            Icons.call,
            const Color(0xFF4CAF50),
            'Call',
            'tel:+919876543210',
          ),
          const SizedBox(height: 8),
          _buildFloatingButton(
            Icons.email,
            const Color(0xFFEA4335),
            'Email',
            'mailto:gaurav@gsworldcenter.com',
          ),
          const SizedBox(height: 8),
          _buildFloatingButton(
            Icons.telegram,
            const Color(0xFF0088CC),
            'Telegram',
            'https://t.me/gsworldcenter',
          ),
          const SizedBox(height: 8),
          _buildFloatingButton(
            Icons.message,
            const Color(0xFF7C3AED),
            'Live Chat',
            'chat',
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingButton(IconData icon, Color color, String label, String link) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Tooltip(
        message: label,
        child: GestureDetector(
          onTap: () {
            // Handle tap
            if (label == 'Live Chat') {
              // Open chat bot
              // You can trigger the chat bot here
            }
          },
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.4),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
}