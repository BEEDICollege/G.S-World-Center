// lib/screens/home/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/scroll_provider.dart';
import '../../core/widgets/app_bar/app_bar_widget.dart';
import '../../core/widgets/app_bar/app_drawer.dart';
import '../../core/widgets/scrolling_news_bar.dart';
import '../../core/widgets/scroll_progress_indicator.dart';
import '../../core/widgets/floating_contact_buttons.dart';
import 'sections/hero_section.dart';
import 'sections/hero_slider_section.dart';
import 'sections/skills_section.dart';
import 'sections/services_section.dart';
import 'sections/projects_section.dart';
import 'sections/experience_section.dart';
import 'sections/education_section.dart';
import 'sections/certificates_section.dart';
import 'sections/testimonials_section.dart';
import 'sections/gallery_section.dart';
import 'sections/statistics_section.dart';
import 'sections/contact_section.dart';
import 'sections/footer_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final provider = Provider.of<ScrollProvider>(context, listen: false);
    provider.updateScrollPosition(_scrollController.offset);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(), // ONLY ONE DRAWER - LEFT SIDE
      // NO endDrawer - REMOVED
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                pinned: true,
                floating: true,
                snap: false,
                expandedHeight: 0,
                backgroundColor: Colors.transparent,
                elevation: 0,
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF2563EB), // Blue
                        Color(0xFF7C3AED), // Purple
                        Color(0xFF06B6D4), // Cyan
                        Color(0xFFEC4899), // Pink
                      ],
                    ),
                  ),
                  child: const AppBarWidget(),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const ScrollingNewsBar(),
                    const HeroSliderSection(),
                    const HeroSection(),
                    const SkillsSection(),
                    ServicesSection(),
                    const ProjectsSection(),
                    const ExperienceSection(),
                    const EducationSection(),
                    const CertificatesSection(),
                    const TestimonialsSection(),
                    const GallerySection(),
                    const StatisticsSection(),
                    const ContactSection(),
                    const FooterSection(),
                  ],
                ),
              ),
            ],
          ),
          const ScrollProgressIndicator(),
          const FloatingContactButtons(),
        ],
      ),
    );
  }
}