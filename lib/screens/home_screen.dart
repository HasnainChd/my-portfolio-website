// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:portfolio_website/widgets/hero_section.dart';

import '../utils/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              HeroSection(),
              // About Section
              Container(
                height: 400,
                color: Colors.green.withOpacity(0.1),
                child: const Center(child: Text('ABOUT SECTION')),
              ),

              // Skills Section
              Container(
                height: 400,
                color: Colors.blue.withOpacity(0.1),
                child: const Center(child: Text('SKILLS SECTION')),
              ),

              // Projects Section
              Container(
                height: 500,
                color: Colors.yellow.withOpacity(0.1),
                child: const Center(child: Text('PROJECTS SECTION')),
              ),

              // Contact Section
              Container(
                height: 300,
                color: Colors.purple.withOpacity(0.1),
                child: const Center(child: Text('CONTACT SECTION')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
