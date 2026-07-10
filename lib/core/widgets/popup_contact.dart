// lib/core/widgets/popup_contact.dart
import 'package:flutter/material.dart';

class PopupContact extends StatelessWidget {
  final VoidCallback onClose;

  const PopupContact({
    super.key,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      top: 0,
      child: Stack(
        children: [
          // Background Overlay
          GestureDetector(
            onTap: onClose,
            child: Container(
              color: Colors.black.withOpacity(0.6),
            ),
          ),
          
          // Popup Content
          Center(
            child: TweenAnimationBuilder(
              duration: const Duration(milliseconds: 500),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, value, child) {
                return Transform.scale(
                  scale: 0.8 + (0.2 * value),
                  child: Opacity(
                    opacity: value,
                    child: Material(
                      elevation: 20,
                      borderRadius: BorderRadius.circular(24),
                      color: const Color(0xFF1A1A2E),
                      child: Container(
                        width: 380,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFF1A1A2E),
                              Color(0xFF0A1628),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: const Color(0xFF06B6D4).withOpacity(0.2),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Close Button
                            Align(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: onClose,
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: const BoxDecoration(
                                    color: Colors.white10,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.white54,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                            
                            // Emoji
                            const Text(
                              '👋',
                              style: TextStyle(fontSize: 48),
                            ),
                            const SizedBox(height: 12),
                            
                            // Title
                            const Text(
                              'Hello!',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            
                            // Description
                            const Text(
                              'Need a Flutter Developer?\nLet\'s build your next project together.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                            ),
                            const SizedBox(height: 20),
                            
                            // Buttons
                            Row(
                              children: [
                                Expanded(
                                  child: _buildPopupButton(
                                    'Contact Now',
                                    Icons.email,
                                    () {
                                      // Open contact
                                      onClose();
                                      // Navigate to contact
                                    },
                                    isPrimary: true,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _buildPopupButton(
                                    'WhatsApp',
                                    Icons.message_rounded,
                                    () {
                                      // Open WhatsApp
                                    },
                                    isPrimary: false,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            
                            // Don't show again
                            TextButton(
                              onPressed: onClose,
                              child: const Text(
                                'Don\'t show again',
                                style: TextStyle(
                                  color: Colors.white38,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopupButton(
    String label,
    IconData icon,
    VoidCallback onTap, {
    bool isPrimary = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          gradient: isPrimary
              ? const LinearGradient(
                  colors: [Color(0xFF06B6D4), Color(0xFF10B981)],
                )
              : const LinearGradient(
                  colors: [Colors.white10, Colors.white],
                ),
          border: isPrimary
              ? null
              : Border.all(
                  color: Colors.white24,
                ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isPrimary ? Colors.white : Colors.white70,
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isPrimary ? Colors.white : Colors.white70,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}