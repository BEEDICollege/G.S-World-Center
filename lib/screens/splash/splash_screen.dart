// lib/screens/splash/splash_screen.dart
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  // Entrance animation (plays once)
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _textGlowAnimation;

  // Infinite pulse for the logo glow
  late final AnimationController _pulseController;
  late final Animation<double> _pulseAnimation;

  // Infinite rotation that drives the orbiting "universe" rings + halo
  late final AnimationController _orbitController;

  // Starry / neural-network background
  late List<_Particle> _particles;
  Timer? _starTimer;
  double _elapsed = 0;

  @override
  void initState() {
    super.initState();

    // 90 particles: mix of twinkling stars + AI "neural" nodes
    _particles = List.generate(90, (index) => _Particle());
    _starTimer = Timer.periodic(const Duration(milliseconds: 40), (timer) {
      _elapsed += 0.04;
      setState(() {
        for (final p in _particles) {
          p.update();
        }
      });
    });

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _textGlowAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.9, curve: Curves.easeInOut),
      ),
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);
    _pulseAnimation = CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    );

    _orbitController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 16),
    )..repeat();

    _controller.forward();

    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        _starTimer?.cancel();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _pulseController.dispose();
    _orbitController.dispose();
    _starTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF05060F),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final height = constraints.maxHeight;
          final logoSize = (width * 0.36).clamp(110.0, 190.0);
          final titleSize = (width * 0.095).clamp(26.0, 46.0);
          final subtitleSize = (width * 0.038).clamp(12.0, 17.0);

          return Container(
            width: width,
            height: height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF0A0E27), // Deep Dark Blue
                  Color(0xFF1A1040), // Deep Purple
                  Color(0xFF0D2137), // Dark Blue
                  Color(0xFF1A0A2E), // Dark Purple
                ],
              ),
            ),
            child: Stack(
              children: [
                // AI Neural Network + Twinkling Star Sky
                Positioned.fill(
                  child: CustomPaint(
                    painter: _CosmicSkyPainter(_particles, _elapsed),
                  ),
                ),

                // Slow animated color wash, brightens as intro plays
                Positioned.fill(
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.transparent,
                              Colors.transparent,
                              const Color(0xFF06B6D4)
                                  .withOpacity(0.06 * _controller.value),
                              const Color(0xFF10B981)
                                  .withOpacity(0.06 * _controller.value),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Main Content
                Center(
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildOrbitingLogo(logoSize),
                        const SizedBox(height: 30),
                        _buildGlowingTitle(titleSize),
                        const SizedBox(height: 8),
                        _buildSubtitle(subtitleSize),
                        const SizedBox(height: 40),
                        _buildLoadingRow(),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildDot(0),
                            const SizedBox(width: 8),
                            _buildDot(1),
                            const SizedBox(width: 8),
                            _buildDot(2),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ---------------------------------------------------------------------
  // Logo with rotating halo + multiple orbit rings ("universe") around it
  // ---------------------------------------------------------------------
  Widget _buildOrbitingLogo(double logoSize) {
    final double haloSize = logoSize * 2.0;
    final radii = [logoSize * 0.62, logoSize * 0.80, logoSize * 0.98];

    return SizedBox(
      width: haloSize,
      height: haloSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Rotating conic (sweep) halo behind everything
          AnimatedBuilder(
            animation: _orbitController,
            builder: (context, child) {
              return Transform.rotate(
                angle: _orbitController.value * 2 * pi,
                child: Container(
                  width: haloSize,
                  height: haloSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: SweepGradient(
                      colors: [
                        Colors.transparent,
                        const Color(0xFF06B6D4).withOpacity(0.22),
                        Colors.transparent,
                        const Color(0xFFFFD700).withOpacity(0.22),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

          // Static faint orbit paths ("universe" rings)
          CustomPaint(
            size: Size(haloSize, haloSize),
            painter: _OrbitRingsPainter(radii),
          ),

          // Satellites travelling around the logo, each its own ring/speed
          _orbitSatellite(
              radius: radii[0],
              speed: 0.55,
              dotSize: 9,
              color: const Color(0xFFFFD700)),
          _orbitSatellite(
              radius: radii[0],
              speed: 0.55,
              dotSize: 5,
              color: const Color(0xFFFFD700),
              phase: pi),
          _orbitSatellite(
              radius: radii[1],
              speed: -0.38,
              dotSize: 7,
              color: const Color(0xFF06B6D4)),
          _orbitSatellite(
              radius: radii[1],
              speed: -0.38,
              dotSize: 4,
              color: const Color(0xFF06B6D4),
              phase: pi * 0.6),
          _orbitSatellite(
              radius: radii[2],
              speed: 0.26,
              dotSize: 8,
              color: const Color(0xFF10B981),
              phase: pi / 2),

          // The glowing, pulsing logo itself
          AnimatedBuilder(
            animation: Listenable.merge([_pulseAnimation, _scaleAnimation]),
            builder: (context, child) {
              final pulse = 0.75 + 0.25 * _pulseAnimation.value;
              return Container(
                width: logoSize,
                height: logoSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFFD700).withOpacity(0.35 * pulse),
                      blurRadius: 60 * pulse,
                      spreadRadius: 18 * pulse,
                    ),
                    BoxShadow(
                      color: const Color(0xFFFFA500).withOpacity(0.22 * pulse),
                      blurRadius: 40 * pulse,
                      spreadRadius: 8 * pulse,
                    ),
                  ],
                ),
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.25),
                        width: 2,
                      ),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/logos/logo.ico',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.white,
                            child: const Center(
                              child: Text(
                                'GS',
                                style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFFFD700),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
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

  Widget _orbitSatellite({
    required double radius,
    required double speed,
    required double dotSize,
    required Color color,
    double phase = 0,
  }) {
    return AnimatedBuilder(
      animation: _orbitController,
      builder: (context, child) {
        final angle = 2 * pi * (_orbitController.value * speed) + phase;
        return Transform.translate(
          offset: Offset(radius * cos(angle), radius * sin(angle)),
          child: child,
        );
      },
      child: Container(
        width: dotSize,
        height: dotSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.75),
              blurRadius: dotSize * 1.6,
              spreadRadius: dotSize * 0.3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGlowingTitle(double fontSize) {
    return AnimatedBuilder(
      animation: _textGlowAnimation,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFFD700), // Gold
              Color(0xFFFFA500), // Orange
              Color(0xFFFFD700), // Gold
              Color(0xFFFFC107), // Amber
            ],
            stops: [0.0, 0.3, 0.7, 1.0],
          ).createShader(bounds),
          child: SlideTransition(
            position: _slideAnimation,
            child: Text(
              'GS World Center',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 2,
                shadows: [
                  Shadow(
                    color: const Color(0xFFFFD700)
                        .withOpacity(0.5 * _textGlowAnimation.value),
                    blurRadius: 30 * _textGlowAnimation.value,
                  ),
                  Shadow(
                    color: const Color(0xFFFFA500)
                        .withOpacity(0.3 * _textGlowAnimation.value),
                    blurRadius: 60 * _textGlowAnimation.value,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSubtitle(double fontSize) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: ShaderMask(
        shaderCallback: (bounds) => const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF06B6D4),
            Color(0xFF10B981),
            Color(0xFF06B6D4),
          ],
        ).createShader(bounds),
        child: Text(
          'Premium Software Solutions',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            letterSpacing: 3,
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              const Color(0xFFFFD700).withOpacity(0.9),
            ),
            strokeWidth: 2.4,
          ),
        ),
        const SizedBox(width: 12),
        const Text(
          'Loading...',
          style: TextStyle(
            fontSize: 13,
            color: Colors.white54,
            letterSpacing: 3,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }

  Widget _buildDot(int index) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final delay = index * 0.2;
        final value = (_controller.value - delay).clamp(0.0, 1.0);
        return Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFFFFD700).withOpacity(0.3 + (0.7 * value)),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFFD700).withOpacity(0.3 * value),
                blurRadius: 10,
              ),
            ],
          ),
        );
      },
    );
  }
}

// ===========================================================================
// Particle: either a twinkling background star or an AI "neural" node.
// Positions are stored as fractions (0..1) of the screen so the whole
// starfield is fully responsive to any screen size.
// ===========================================================================
class _Particle {
  double x;
  double y;
  double vx;
  double vy;
  double radius;
  double baseOpacity;
  double twinklePhase;
  double twinkleSpeed;
  final Color color;
  final bool isNode; // true = neural network node, false = pure star

  _Particle()
      : x = Random().nextDouble(),
        y = Random().nextDouble(),
        vx = (Random().nextDouble() - 0.5) * 0.0009,
        vy = (Random().nextDouble() - 0.5) * 0.0009,
        radius = Random().nextDouble() * 2.2 + 0.7,
        baseOpacity = Random().nextDouble() * 0.5 + 0.4,
        twinklePhase = Random().nextDouble() * 2 * pi,
        twinkleSpeed = Random().nextDouble() * 2.2 + 0.8,
        isNode = Random().nextDouble() < 0.35,
        color = _pickColor();

  static Color _pickColor() {
    const options = [
      Colors.white,
      Color(0xFF06B6D4),
      Color(0xFFFFD700),
      Color(0xFFB794F6),
    ];
    return options[Random().nextInt(options.length)];
  }

  void update() {
    x += vx;
    y += vy;
    if (x < 0 || x > 1) vx = -vx;
    if (y < 0 || y > 1) vy = -vy;
  }

  double opacityAt(double time) {
    final twinkle = 0.5 + 0.5 * sin(time * twinkleSpeed + twinklePhase);
    return (baseOpacity * (0.3 + 0.7 * twinkle)).clamp(0.0, 1.0);
  }
}

// Draws the starry sky + faint AI neural-network connections.
class _CosmicSkyPainter extends CustomPainter {
  final List<_Particle> particles;
  final double time;

  _CosmicSkyPainter(this.particles, this.time);

  @override
  void paint(Canvas canvas, Size size) {
    // Precompute pixel positions once.
    final positions = particles
        .map((p) => Offset(p.x * size.width, p.y * size.height))
        .toList(growable: false);

    // Neural-network style connecting lines between nearby "node" particles.
    for (int i = 0; i < particles.length; i++) {
      if (!particles[i].isNode) continue;
      for (int j = i + 1; j < particles.length; j++) {
        if (!particles[j].isNode) continue;
        final dx = positions[i].dx - positions[j].dx;
        final dy = positions[i].dy - positions[j].dy;
        final distance = sqrt(dx * dx + dy * dy);

        if (distance < 140) {
          final opacity = (1 - distance / 140) * 0.28;
          final linePaint = Paint()
            ..color = const Color(0xFF06B6D4).withOpacity(opacity)
            ..strokeWidth = 1;

          if (distance < 75) {
            linePaint
              ..color = const Color(0xFFFFD700).withOpacity(opacity * 1.5)
              ..strokeWidth = 1.4;
          }

          canvas.drawLine(positions[i], positions[j], linePaint);
        }
      }
    }

    // Stars / nodes themselves, all twinkling.
    for (int i = 0; i < particles.length; i++) {
      final p = particles[i];
      final pos = positions[i];
      final opacity = p.opacityAt(time);

      if (p.radius > 1.8) {
        canvas.drawCircle(
          pos,
          p.radius * 3.2,
          Paint()..color = const Color(0xFFFFD700).withOpacity(0.06 * opacity),
        );
      }

      canvas.drawCircle(
        pos,
        p.radius,
        Paint()
          ..color = p.color.withOpacity(opacity)
          ..style = PaintingStyle.fill,
      );

      // Sparkle cross for brighter stars.
      if (p.radius > 2.0 && opacity > 0.6) {
        final sparkle = Paint()
          ..color = Colors.white.withOpacity((opacity - 0.6) * 1.2)
          ..strokeWidth = 0.8;
        final s = p.radius * 2.6;
        canvas.drawLine(
          Offset(pos.dx - s, pos.dy),
          Offset(pos.dx + s, pos.dy),
          sparkle,
        );
        canvas.drawLine(
          Offset(pos.dx, pos.dy - s),
          Offset(pos.dx, pos.dy + s),
          sparkle,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _CosmicSkyPainter oldDelegate) => true;
}

// Draws the faint circular "orbit" paths around the logo.
class _OrbitRingsPainter extends CustomPainter {
  final List<double> radii;

  _OrbitRingsPainter(this.radii);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    for (final r in radii) {
      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.1
        ..color = Colors.white.withOpacity(0.10);
      canvas.drawCircle(center, r, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _OrbitRingsPainter oldDelegate) =>
      oldDelegate.radii != radii;
}
