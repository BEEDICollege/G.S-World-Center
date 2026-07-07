import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

import 'core/theme/app_theme.dart';
import 'core/providers/theme_provider.dart';
import 'core/providers/language_provider.dart';
import 'core/providers/scroll_provider.dart';

import 'screens/splash/splash_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/about/about_screen.dart';
import 'screens/skills/skills_screen.dart';
import 'services/services_screen.dart';
import 'screens/projects/projects_screen.dart';
import 'screens/experience/experience_screen.dart';
import 'screens/education/education_screen.dart';
import 'screens/certificates/certificates_screen.dart';
import 'screens/testimonials/testimonials_screen.dart';
import 'screens/gallery/gallery_screen.dart';
import 'screens/blog/blog_screen.dart';
import 'screens/contact/contact_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => ScrollProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'G.S World Center',

            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,

            initialRoute: '/',

            routes: {
              '/': (context) => const SplashScreen(),
              '/home': (context) => const HomeScreen(),
              '/about': (context) => const AboutScreen(),
              '/skills': (context) => const SkillsScreen(),
              '/services': (context) => const ServicesScreen(),
              '/projects': (context) => const ProjectsScreen(),
              '/experience': (context) => const ExperienceScreen(),
              '/education': (context) => const EducationScreen(),
              '/certificates': (context) => const CertificatesScreen(),
              '/testimonials': (context) => const TestimonialsScreen(),
              '/gallery': (context) => const GalleryScreen(),
              '/blog': (context) => const BlogScreen(),
              '/contact': (context) => const ContactScreen(),
            },
          );
        },
      ),
    );
  }
}