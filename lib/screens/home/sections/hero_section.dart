// lib/screens/home/sections/hero_section.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../core/constants/app_colors.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  
  // Profile images for auto-change (30 seconds interval)
  final List<String> profileImages = [
    'assets/images/profile1.jpeg',
    'assets/images/profile2.jpeg',
    'assets/images/profile3.jpeg',
    'assets/images/profile4.jpeg',
    'assets/images/profile5.jpeg',
    'assets/images/profile6.jpeg',
  ];
  
  int _currentImageIndex = 0;
  late Timer _imageTimer;

  // Typing animation variables
  final List<String> _titles = [
    'Flutter Developer',
    'Full Stack Developer',
    'FastAPI Expert',
    'AI Enthusiast',
    'UI/UX Designer',
    'Mobile App Developer',
  ];
  int _currentTitleIndex = 0;
  String _displayText = '';
  bool _isDeleting = false;
  int _typingIndex = 0;
  late Timer _typingTimer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();

    // Start auto-changing profile images every 30 seconds
    _imageTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      if (mounted) {
        setState(() {
          _currentImageIndex = (_currentImageIndex + 1) % profileImages.length;
        });
      }
    });

    // Start typing animation
    _startTypingAnimation();
  }

  void _startTypingAnimation() {
    _typingTimer = Timer.periodic(const Duration(milliseconds: 150), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      
      setState(() {
        if (_isDeleting) {
          if (_displayText.isNotEmpty) {
            _displayText = _displayText.substring(0, _displayText.length - 1);
          } else {
            _isDeleting = false;
            _currentTitleIndex = (_currentTitleIndex + 1) % _titles.length;
          }
        } else {
          if (_displayText.length < _titles[_currentTitleIndex].length) {
            _displayText = _titles[_currentTitleIndex].substring(
              0, 
              _displayText.length + 1
            );
          } else {
            // Pause before deleting
            Future.delayed(const Duration(seconds: 2), () {
              if (mounted) {
                setState(() {
                  _isDeleting = true;
                });
              }
            });
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _imageTimer.cancel();
    _typingTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF0A1628), // Dark Blue
            const Color(0xFF0D2B3E), // Dark Blue-Green
            const Color(0xFF0F3D3D), // Green
            const Color(0xFF0A2E3A), // Blue-Green
          ],
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 600;
          final isTablet = constraints.maxWidth < 900;

          return Row(
            children: [
              Expanded(
                flex: isMobile ? 1 : 1,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Welcome Badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF06B6D4),
                                Color(0xFF10B981),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Welcome to GS World Center',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        
                        // Name with Gradient
                        ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFF06B6D4),
                              Color(0xFF10B981),
                              Color(0xFF2563EB),
                            ],
                          ).createShader(bounds),
                          child: const Text(
                            'Gaurav Kumar',
                            style: TextStyle(
                              fontSize: 42,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        
                        // Typing Animation Text
                        Row(
                          children: [
                            const Text(
                              'I am ',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white70,
                              ),
                            ),
                            Text(
                              _displayText,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF06B6D4),
                              ),
                            ),
                            const SizedBox(width: 2),
                            Container(
                              width: 2,
                              height: 24,
                              color: const Color(0xFF06B6D4),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        
                        // Tags
                        Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          children: const [
                            TagChip(label: 'Flutter Developer', color: Color(0xFF06B6D4)),
                            TagChip(label: 'Full Stack Developer', color: Color(0xFF10B981)),
                            TagChip(label: 'AI Enthusiast', color: Color(0xFF2563EB)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        
                        // Description
                        const Text(
                          'Building premium digital experiences with cutting-edge technology',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white60,
                          ),
                        ),
                        const SizedBox(height: 30),
                        
                        // CTA Buttons
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            _buildCTAButton('Download Resume', Icons.download, isMobile),
                            _buildCTAButton('Hire Me', Icons.work_outline, isMobile,
                                isPrimary: true),
                            _buildCTAButton('Contact Me', Icons.email_outlined, isMobile),
                            _buildCTAButton('View Projects', Icons.grid_view, isMobile),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (!isMobile)
                Expanded(
                  flex: 1,
                  child: _buildProfileImage(),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCTAButton(String label, IconData icon, bool isMobile,
      {bool isPrimary = false}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          gradient: isPrimary
              ? const LinearGradient(
                  colors: [Color(0xFF06B6D4), Color(0xFF10B981)],
                )
              : const LinearGradient(
                  colors: [Colors.transparent, Colors.transparent],
                ),
          border: Border.all(
            color: isPrimary ? Colors.transparent : Colors.white24,
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: isPrimary
              ? [
                  BoxShadow(
                    color: const Color(0xFF06B6D4).withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: isPrimary ? Colors.white : Colors.white70),
            const SizedBox(width: 8),
            Text(
              isMobile ? label.split(' ').first : label,
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

  Widget _buildProfileImage() {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Animated Gradient Background
          Container(
            width: 340,
            height: 340,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF06B6D4),
                  Color(0xFF10B981),
                  Color(0xFF2563EB),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF06B6D4).withOpacity(0.3),
                  blurRadius: 60,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF0A1628),
                ),
                child: ClipOval(
                  child: Image.asset(
                    profileImages[_currentImageIndex],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: const Color(0xFF0A1628),
                        child: const Center(
                          child: Icon(
                            Icons.person,
                            size: 100,
                            color: Colors.white54,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          // Outer Rings
          Container(
            width: 380,
            height: 380,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFF06B6D4).withOpacity(0.2),
                width: 2,
              ),
            ),
          ),
          Container(
            width: 420,
            height: 420,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFF10B981).withOpacity(0.1),
                width: 1,
              ),
            ),
          ),
          // Index Badge
          Positioned(
            bottom: 10,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFF06B6D4).withOpacity(0.3),
                ),
              ),
              child: Text(
                '${_currentImageIndex + 1}/${profileImages.length}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Tag Chip Widget
class TagChip extends StatelessWidget {
  final String label;
  final Color color;

  const TagChip({
    super.key,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.3),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}