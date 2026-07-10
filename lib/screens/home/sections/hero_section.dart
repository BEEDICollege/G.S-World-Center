// lib/screens/home/sections/hero_section.dart
import 'dart:async';
import 'package:flutter/material.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  final List<String> _titles = [
    'Flutter Developer',
    'Full Stack Developer',
    'FastAPI Expert',
    'AI Enthusiast',
    'UI/UX Designer',
    'Mobile App Developer',
  ];
  
  int _currentIndex = 0;
  String _displayText = '';
  bool _isDeleting = false;
  Timer? _typingTimer;

  @override
  void initState() {
    super.initState();
    _startTyping();
  }

  void _startTyping() {
    _typingTimer = Timer.periodic(const Duration(milliseconds: 120), (timer) {
      setState(() {
        if (_isDeleting) {
          if (_displayText.isNotEmpty) {
            _displayText = _displayText.substring(0, _displayText.length - 1);
          } else {
            _isDeleting = false;
            _currentIndex = (_currentIndex + 1) % _titles.length;
          }
        } else {
          if (_displayText.length < _titles[_currentIndex].length) {
            _displayText = _titles[_currentIndex].substring(0, _displayText.length + 1);
          } else {
            Future.delayed(const Duration(seconds: 2), () {
              if (mounted) {
                setState(() => _isDeleting = true);
              }
            });
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _typingTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        final isTablet = constraints.maxWidth < 900;
        
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 40,
            vertical: isMobile ? 30 : 50,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF0A0E27),
                const Color(0xFF1A1040),
                const Color(0xFF0D2137),
                const Color(0xFF0A0E27),
              ],
            ),
          ),
          child: isMobile
              ? _buildMobileLayout()
              : _buildDesktopLayout(),
        );
      },
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: _buildContent(),
        ),
        const SizedBox(width: 40),
        Expanded(
          flex: 1,
          child: _buildProfileCard(),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildContent(),
        const SizedBox(height: 30),
        _buildProfileCard(),
      ],
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Welcome Badge
        TweenAnimationBuilder(
          duration: const Duration(milliseconds: 800),
          tween: Tween<double>(begin: 0, end: 1),
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(-30 * (1 - value), 0),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF06B6D4), Color(0xFF10B981)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star, color: Colors.white, size: 14),
                      SizedBox(width: 6),
                      Text(
                        'Welcome to GS World Center',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 20),
        
        // Name with Gradient
        TweenAnimationBuilder(
          duration: const Duration(milliseconds: 1000),
          tween: Tween<double>(begin: 0, end: 1),
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, 30 * (1 - value)),
                child: ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFFFD700),
                      Color(0xFFFFA500),
                      Color(0xFFFF6B00),
                    ],
                  ).createShader(bounds),
                  child: const Text(
                    'Gaurav Kumar',
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 8),
        
        // Typing Animation
        TweenAnimationBuilder(
          duration: const Duration(milliseconds: 1200),
          tween: Tween<double>(begin: 0, end: 1),
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Row(
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
                  Container(
                    width: 2,
                    height: 24,
                    color: const Color(0xFF06B6D4),
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 12),
        
        // Tags
        TweenAnimationBuilder(
          duration: const Duration(milliseconds: 1400),
          tween: Tween<double>(begin: 0, end: 1),
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Wrap(
                spacing: 8,
                runSpacing: 4,
                children: const [
                  TagChip(label: 'Flutter Developer', color: Color(0xFF06B6D4)),
                  TagChip(label: 'Full Stack', color: Color(0xFF10B981)),
                  TagChip(label: 'AI Enthusiast', color: Color(0xFFFFD700)),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        
        // Description
        TweenAnimationBuilder(
          duration: const Duration(milliseconds: 1600),
          tween: Tween<double>(begin: 0, end: 1),
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: const Text(
                'Building premium digital experiences with cutting-edge technology',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white60,
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 24),
        
        // CTA Buttons
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _buildCTAButton('Download Resume', Icons.download, true),
            _buildCTAButton('Hire Me', Icons.work_outline, false),
            _buildCTAButton('Contact Me', Icons.email_outlined, false),
            _buildCTAButton('View Projects', Icons.grid_view, false),
          ],
        ),
      ],
    );
  }

  Widget _buildCTAButton(String label, IconData icon, bool isPrimary) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: TweenAnimationBuilder(
        duration: const Duration(milliseconds: 300),
        tween: Tween<double>(begin: 1, end: 1),
        builder: (context, value, child) {
          return Transform.scale(
            scale: value,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                gradient: isPrimary
                    ? const LinearGradient(
                        colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
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
                          color: const Color(0xFFFFD700).withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, size: 16, color: isPrimary ? Colors.black : Colors.white70),
                  const SizedBox(width: 6),
                  Text(
                    label,
                    style: TextStyle(
                      color: isPrimary ? Colors.black : Colors.white70,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileCard() {
    // List of profile images for auto-change (optional)
    final List<String> profileImages = [
      'assets/images/profile1.jpeg',
      'assets/images/profile2.jpeg',
      'assets/imagess/profile3.jpeg',
      'assets/images/profile4.jpeg',
      'assets/images/profile5.jpeg',
      'assets/images/profile6.jpeg',
    ];
    
    // Use first image as default or change based on your preference
    final String profileImage = profileImages[0]; // Change index to show different image
    
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 1500),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.scale(
            scale: 0.8 + (0.2 * value),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.05),
                    Colors.white.withOpacity(0.02),
                  ],
                ),
                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  // Profile Image with Glow
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      // Outer Glow
                      Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFFFFD700),
                              Color(0xFFFFA500),
                              Color(0xFF06B6D4),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFFFD700).withOpacity(0.3),
                              blurRadius: 40,
                              spreadRadius: 10,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF0A0E27),
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                profileImage, // ← YOUR PROFILE PICTURE HERE
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  // Fallback if image doesn't load
                                  return Container(
                                    color: const Color(0xFF0A0E27),
                                    child: const Center(
                                      child: Icon(
                                        Icons.person,
                                        size: 80,
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
                      // Animated Ring 1
                      TweenAnimationBuilder(
                        duration: const Duration(seconds: 3),
                        tween: Tween<double>(begin: 0, end: 1),
                        builder: (context, angle, child) {
                          return Transform.rotate(
                            angle: angle * 6.28,
                            child: Container(
                              width: 220,
                              height: 220,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0xFFFFD700).withOpacity(0.1),
                                  width: 1,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      // Animated Ring 2 (Opposite direction)
                      TweenAnimationBuilder(
                        duration: const Duration(seconds: 4),
                        tween: Tween<double>(begin: 0, end: 1),
                        builder: (context, angle, child) {
                          return Transform.rotate(
                            angle: -angle * 6.28,
                            child: Container(
                              width: 235,
                              height: 235,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0xFF06B6D4).withOpacity(0.08),
                                  width: 1,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      // Profile Status Badge
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF10B981),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFF0A0E27),
                              width: 2,
                            ),
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Stats Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildMiniStat('Projects', '100+', const Color(0xFF06B6D4)),
                      _buildMiniStat('Clients', '50+', const Color(0xFF10B981)),
                      _buildMiniStat('Experience', '5+', const Color(0xFFFFD700)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMiniStat(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.white54,
          ),
        ),
      ],
    );
  }
}

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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
          fontSize: 10,
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}