// lib/screens/certificates/certificates_screen.dart
import 'package:flutter/material.dart';

class CertificatesScreen extends StatelessWidget {
  const CertificatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Certificates'),
        backgroundColor: const Color(0xFF1A1A2E),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: const [
              Color(0xFF0A0A0F),
              Color(0xFF1A1A2E),
            ],
          ),
        ),
        child: const Center(
          child: Text(
            'Certificates Page - Coming Soon',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
      ),
    );
  }
}