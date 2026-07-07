// lib/screens/home/sections/hero_slider_section.dart
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HeroSliderSection extends StatefulWidget {
  const HeroSliderSection({super.key});

  @override
  State<HeroSliderSection> createState() => _HeroSliderSectionState();
}

class _HeroSliderSectionState extends State<HeroSliderSection> {
  int _currentIndex = 0;
 
final CarouselSliderController _carouselController =
    CarouselSliderController();

  // Profile images list - update with your actual image names
  final List<String> profileImages = [
    'assets/images/profile1.jpeg',
    'assets/images/profile2.jpeg',
    'assets/images/profile3.jpeg',
    'assets/images/profile4.jpeg',
    'assets/images/profile5.jpeg',
    'assets/images/profile6.jpeg',
  ];

  // Fallback images in case assets don't load
  final List<Color> fallbackColors = [
    const Color(0xFF2563EB),
    const Color(0xFF7C3AED),
    const Color(0xFF06B6D4),
    const Color(0xFFEC4899),
    const Color(0xFFF59E0B),
    const Color(0xFF10B981),
  ];

  final List<String> titles = [
    'Flutter Developer',
    'Full Stack Developer',
    'FastAPI Expert',
    'AI Enthusiast',
    'UI/UX Designer',
    'Mobile App Developer',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(0.3),
            Colors.transparent,
          ],
        ),
      ),
      child: Stack(
        children: [
          // Background Gradient
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF2563EB).withOpacity(0.1),
                    const Color(0xFF7C3AED).withOpacity(0.1),
                    const Color(0xFF06B6D4).withOpacity(0.1),
                  ],
                ),
              ),
            ),
          ),

          // Carousel Slider
          CarouselSlider(
            carouselController: _carouselController,
            options: CarouselOptions(
              height: 400,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 1000),
              autoPlayCurve: Curves.easeInOut,
              enlargeCenterPage: true,
              enlargeFactor: 0.2,
              viewportFraction: 0.8,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            items: profileImages.asMap().entries.map((entry) {
              int index = entry.key;
              String imagePath = entry.value;

              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: fallbackColors[index % fallbackColors.length]
                              .withOpacity(0.3),
                          blurRadius: 40,
                          spreadRadius: 5,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          // Profile Image
                          Image.asset(
                            imagePath,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              // If image fails to load, show gradient fallback
                              return Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      fallbackColors[
                                          index % fallbackColors.length],
                                      fallbackColors[
                                          (index + 1) % fallbackColors.length],
                                    ],
                                  ),
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.person,
                                        size: 80,
                                        color: Colors.white54,
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        'GS World Center',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white.withOpacity(0.8),
                                        ),
                                      ),
                                      Text(
                                        titles[index % titles.length],
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white.withOpacity(0.6),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),

                          // Gradient Overlay
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black.withOpacity(0.6),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),

                          // Title Overlay
                          Positioned(
                            bottom: 30,
                            left: 20,
                            right: 20,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'GS World Center',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 10,
                                        color: Colors.black26,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  titles[index % titles.length],
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white.withOpacity(0.8),
                                    shadows: [
                                      const Shadow(
                                        blurRadius: 10,
                                        color: Colors.black26,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // GS Logo in Corner
                          Positioned(
                            top: 16,
                            right: 16,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.2),
                                ),
                              ),
                              child: Image.asset(
                                'assets/logos/logo.jpeg',
                                height: 40,
                                width: 40,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(
                                    Icons.photo,
                                    color: Colors.white,
                                    size: 30,
                                  );
                                },
                              ),
                            ),
                          ),

                          // Index Badge
                          Positioned(
                            top: 16,
                            left: 16,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.2),
                                ),
                              ),
                              child: Text(
                                '${index + 1}/${profileImages.length}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),

          // Navigation Buttons
          Positioned(
            left: 10,
            top: 0,
            bottom: 0,
            child: Center(
              child: _buildNavButton(
                Icons.chevron_left,
                () {
                  _carouselController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ),
          ),
          Positioned(
            right: 10,
            top: 0,
            bottom: 0,
            child: Center(
              child: _buildNavButton(
                Icons.chevron_right,
                () {
                  _carouselController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ),
          ),

          // Dot Indicators
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: profileImages.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () {
                    _carouselController.animateToPage(
                      entry.key,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Container(
                    width: _currentIndex == entry.key ? 30 : 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      gradient: _currentIndex == entry.key
                          ? const LinearGradient(
                              colors: [
                                Color(0xFF2563EB),
                                Color(0xFF7C3AED),
                                Color(0xFF06B6D4),
                              ],
                            )
                          : null,
                      color: _currentIndex == entry.key
                          ? null
                          : Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white.withOpacity(0.2),
          ),
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }
}