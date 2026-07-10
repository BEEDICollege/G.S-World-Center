// lib/core/widgets/floating_social_buttons.dart
import 'package:flutter/material.dart';

class FloatingSocialButtons extends StatefulWidget {
  const FloatingSocialButtons({super.key});

  @override
  State<FloatingSocialButtons> createState() => _FloatingSocialButtonsState();
}

class _FloatingSocialButtonsState extends State<FloatingSocialButtons>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _rotateAnimation = Tween<double>(begin: 0, end: 0.5).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 100,
      left: 24,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Social Buttons
          if (_isExpanded) ...[
            _buildSocialFloatingButton(
              Icons.code,
              'GitHub',
              Colors.black,
              const Offset(0, -180),
            ),
            _buildSocialFloatingButton(
              Icons.work,
              'LinkedIn',
              Colors.blue,
              const Offset(0, -140),
            ),
            _buildSocialFloatingButton(
              Icons.camera_alt,
              'Instagram',
              Colors.purple,
              const Offset(0, -100),
            ),
            _buildSocialFloatingButton(
              Icons.video_library,
              'YouTube',
              Colors.red,
              const Offset(0, -60),
            ),
            _buildSocialFloatingButton(
              Icons.chat,
              'WhatsApp',
              Colors.green,
              const Offset(0, -20),
            ),
          ],
          
          // Main Button
          AnimatedBuilder(
            animation: _rotateAnimation,
            builder: (context, child) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                    if (_isExpanded) {
                      _controller.forward();
                    } else {
                      _controller.reverse();
                    }
                  });
                },
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFFD700).withOpacity(0.3),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Transform.rotate(
                    angle: _rotateAnimation.value * 6.28,
                    child: Icon(
                      _isExpanded ? Icons.close : Icons.share,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSocialFloatingButton(
    IconData icon,
    String label,
    Color color,
    Offset offset,
  ) {
    return Positioned(
      bottom: 0,
      left: 0,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.translationValues(
          offset.dx * (_isExpanded ? 1 : 0),
          offset.dy * (_isExpanded ? 1 : 0),
          0,
        ),
        child: Opacity(
          opacity: _isExpanded ? 1 : 0,
          child: GestureDetector(
            onTap: () {
              // Open social media
            },
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.3),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Icon(icon, color: Colors.white, size: 20),
            ),
          ),
        ),
      ),
    );
  }
}