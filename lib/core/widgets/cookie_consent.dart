// lib/core/widgets/cookie_consent.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CookieConsent extends StatefulWidget {
  const CookieConsent({super.key});

  @override
  State<CookieConsent> createState() => _CookieConsentState();
}

class _CookieConsentState extends State<CookieConsent> {
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    _checkConsent();
  }

  void _checkConsent() async {
    final prefs = await SharedPreferences.getInstance();
    final consented = prefs.getBool('cookie_consent') ?? false;
    if (consented) {
      setState(() {
        _isVisible = false;
      });
    }
  }

  void _acceptCookies() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('cookie_consent', true);
    setState(() {
      _isVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isVisible) return const SizedBox.shrink();

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0A1628),
              Color(0xFF0D2B3E),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              const Icon(
                Icons.cookie,
                color: Color(0xFFFFD700),
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      '🍪 Cookie Consent',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'We use cookies to improve your experience.',
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: _acceptCookies,
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFF06B6D4),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('Accept'),
              ),
              const SizedBox(width: 8),
              TextButton(
                onPressed: () {
                  setState(() {
                    _isVisible = false;
                  });
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white60,
                ),
                child: const Text('Dismiss'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}