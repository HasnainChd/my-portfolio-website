import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../widgets/hero_section.dart';
import '../widgets/about_section.dart';
import '../widgets/project_section.dart';
import '../widgets/skill_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  int _currentSection = 0;

  final List<GlobalKey> _sectionKeys = List.generate(
    5,
    (index) => GlobalKey(),
  );

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final screenHeight = MediaQuery.of(context).size.height;

    for (int i = _sectionKeys.length - 1; i >= 0; i--) {
      final RenderBox? box =
          _sectionKeys[i].currentContext?.findRenderObject() as RenderBox?;
      if (box != null) {
        final position = box
            .localToGlobal(Offset.zero, ancestor: context.findRenderObject())
            .dy;

        if (position <= screenHeight / 2) {
          if (_currentSection != i) {
            setState(() => _currentSection = i);
          }
          break;
        }
      }
    }
  }

  void _scrollToSection(int index) {
    final RenderBox? box =
        _sectionKeys[index].currentContext?.findRenderObject() as RenderBox?;

    if (box != null) {
      final position = box.localToGlobal(Offset.zero).dy;
      final currentScroll = _scrollController.offset;
      final targetScroll = currentScroll + position - 80;

      _scrollController.animateTo(
        targetScroll,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: AppColors.backgroundGradient,
            ),
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  const SizedBox(height: 80),
                  Container(
                    key: _sectionKeys[0],
                    child: HeroSection(
                      onViewProjectsTap: () => _scrollToSection(3),
                      onContactTap: () => _scrollToSection(4),
                    ),
                  ),
                  Container(
                    key: _sectionKeys[1],
                    child: const AboutSection(),
                  ),
                  Container(
                    key: _sectionKeys[2],
                    child: const SkillsSection(),
                  ),
                  Container(
                    key: _sectionKeys[3],
                    child: const ProjectsSection(),
                  ),
                  Container(
                    key: _sectionKeys[4],
                    child: const ContactSection(),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavBar(
              currentIndex: _currentSection,
              onNavItemTapped: _scrollToSection,
            ),
          ),
        ],
      ),
    );
  }
}
