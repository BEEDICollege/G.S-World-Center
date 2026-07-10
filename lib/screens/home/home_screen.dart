// lib/screens/home/home_screen.dart
import 'package:flutter/material.dart';
import 'package:gs_world_center/screens/home/sections/stats_overview.dart';
import 'package:provider/provider.dart';
import '../../core/providers/scroll_provider.dart';
import '../../core/widgets/app_bar/app_bar_widget.dart';
import '../../core/widgets/app_bar/app_drawer.dart';
import '../../core/widgets/scrolling_news_bar.dart';
import '../../core/widgets/scroll_progress_indicator.dart';
import '../../core/widgets/floating_contact_buttons.dart';
import '../../core/widgets/back_to_top_button.dart';
import '../../core/widgets/section_animator.dart';
import '../../core/widgets/chat_bot_widget.dart';
import '../../core/widgets/floating_social_buttons.dart';
import '../../core/widgets/visitor_counter.dart';
import '../../core/widgets/cookie_consent.dart';
import '../../core/widgets/maintenance_banner.dart';
import '../../core/widgets/popup_contact.dart';
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
  bool _showBackToTop = false;
  bool _showPopup = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    Future.delayed(const Duration(seconds: 20), () {
      if (mounted) {
        setState(() {
          _showPopup = true;
        });
      }
    });
  }

  void _onScroll() {
    final provider = Provider.of<ScrollProvider>(context, listen: false);
    provider.updateScrollPosition(_scrollController.offset);

    setState(() {
      _showBackToTop = _scrollController.offset > 500;
    });
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        final isTablet = constraints.maxWidth < 900;

        return Scaffold(
          key: _scaffoldKey,
          drawer: const AppDrawer(),
          body: Stack(
            children: [
              CustomScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                slivers: [
                  // Premium App Bar
                  SliverAppBar(
                    pinned: true,
                    floating: true,
                    snap: false,
                    expandedHeight: 0,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    flexibleSpace: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            const Color(0xFF0A0E27),
                            const Color(0xFF1A1040),
                            const Color(0xFF0D2137),
                          ],
                        ),
                      ),
                      child: const AppBarWidget(),
                    ),
                  ),

                  // Main Content
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        const MaintenanceBanner(showBanner: false),
                        const ScrollingNewsBar(),

                        // Hero Slider Section - Full Width
                        const SectionAnimator(
                          delay: 0,
                          duration: Duration(milliseconds: 600),
                          child: HeroSliderSection(),
                        ),

                        const SizedBox(height: 20),

                        // Hero Section - Redesigned
                        const SectionAnimator(
                          delay: 0.1,
                          duration: Duration(milliseconds: 600),
                          child: HeroSection(),
                        ),

                        const SizedBox(height: 40),

                        // Floating Stats Cards
                        const SectionAnimator(
                          delay: 0.2,
                          duration: Duration(milliseconds: 600),
                          child: StatsOverview(),
                        ),

                        const SizedBox(height: 40),

                        // Skills Section
                        const SectionAnimator(
                          delay: 0.3,
                          duration: Duration(milliseconds: 600),
                          child: SkillsSection(),
                        ),

                        const SizedBox(height: 40),

                        // Services Section
                        SectionAnimator(
                          delay: 0.4,
                          duration: const Duration(milliseconds: 600),
                          child: ServicesSection(),
                        ),

                        const SizedBox(height: 40),

                        // Projects Section
                        const SectionAnimator(
                          delay: 0.5,
                          duration: Duration(milliseconds: 600),
                          child: ProjectsSection(),
                        ),

                        const SizedBox(height: 40),

                        // Experience Section
                        const SectionAnimator(
                          delay: 0.6,
                          duration: Duration(milliseconds: 600),
                          child: ExperienceSection(),
                        ),

                        const SizedBox(height: 40),

                        // Education Section
                        const SectionAnimator(
                          delay: 0.7,
                          duration: Duration(milliseconds: 600),
                          child: EducationSection(),
                        ),

                        const SizedBox(height: 40),

                        // Certificates Section
                        const SectionAnimator(
                          delay: 0.8,
                          duration: Duration(milliseconds: 600),
                          child: CertificatesSection(),
                        ),

                        const SizedBox(height: 40),

                        // Testimonials Section
                        const SectionAnimator(
                          delay: 0.9,
                          duration: Duration(milliseconds: 600),
                          child: TestimonialsSection(),
                        ),

                        const SizedBox(height: 40),

                        // Gallery Section
                        const SectionAnimator(
                          delay: 1.0,
                          duration: Duration(milliseconds: 600),
                          child: GallerySection(),
                        ),

                        const SizedBox(height: 40),

                        // Statistics Section
                        const SectionAnimator(
                          delay: 1.1,
                          duration: Duration(milliseconds: 600),
                          child: StatisticsSection(),
                        ),

                        const SizedBox(height: 40),

                        // Contact Section
                        const SectionAnimator(
                          delay: 1.2,
                          duration: Duration(milliseconds: 600),
                          child: ContactSection(),
                        ),

                        // Footer Section
                        const FooterSection(),
                      ],
                    ),
                  ),
                ],
              ),

              // Floating Elements
              const ScrollProgressIndicator(),
              const ChatBotWidget(),
              const FloatingSocialButtons(),
              const FloatingContactButtons(),
              const VisitorCounter(),
              const CookieConsent(),

              if (_showBackToTop)
                BackToTopButton(
                  onTap: _scrollToTop,
                ),

              if (_showPopup)
                PopupContact(
                  onClose: () {
                    setState(() {
                      _showPopup = false;
                    });
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}
