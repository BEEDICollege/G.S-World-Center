// lib/screens/home/sections/testimonials_section.dart
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class TestimonialsSection extends StatefulWidget {
  const TestimonialsSection({super.key});

  @override
  State<TestimonialsSection> createState() => _TestimonialsSectionState();
}

class _TestimonialsSectionState extends State<TestimonialsSection> {
  int _currentIndex = 0;

  final List<Map<String, dynamic>> testimonials = const [
    {
      'name': 'John Doe',
      'company': 'Tech Corp',
      'rating': 5,
      'review': 'Amazing work! GS World Center delivered beyond expectations.',
    },
    {
      'name': 'Jane Smith',
      'company': 'Startup Inc',
      'rating': 5,
      'review': 'Professional and reliable. Highly recommend for Flutter development.',
    },
    {
      'name': 'Mike Johnson',
      'company': 'Enterprise Ltd',
      'rating': 5,
      'review': 'Excellent communication and technical skills. Will work again.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Testimonials',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'What clients say about me',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white60,
            ),
          ),
          const SizedBox(height: 30),
          CarouselSlider(
            options: CarouselOptions(
              height: 200,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 4),
              enlargeCenterPage: true,
              viewportFraction: 0.8,
              onPageChanged: (index, _) {
                setState(() => _currentIndex = index);
              },
            ),
            items: testimonials.map((testimonial) {
              return Container(
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
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        5,
                        (index) => Icon(
                          Icons.star,
                          color: index < testimonial['rating']
                              ? const Color(0xFFFFD700)
                              : Colors.grey,
                          size: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      testimonial['review'],
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      testimonial['name'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      testimonial['company'],
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.cyan,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: testimonials.asMap().entries.map((entry) {
              return Container(
                width: _currentIndex == entry.key ? 30 : 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: _currentIndex == entry.key
                      ? const Color(0xFF2563EB)
                      : Colors.white30,
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}