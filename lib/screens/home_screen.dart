import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/app_colors.dart';
import '../widgets/hero_section.dart';
import '../widgets/about_section.dart';
import '../widgets/project_section.dart';
import '../widgets/skill_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/experience_section.dart';
import '../widgets/nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  int _currentSection = 0;
  Timer? _scrollDownTimer;
  Timer? _scrollUpTimer;

  final List<GlobalKey> _sectionKeys = List.generate(
    6,
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
    _scrollDownTimer?.cancel();
    _scrollUpTimer?.cancel();
    super.dispose();
  }

  void _startScrollDown() {
    _scrollDownTimer?.cancel();
    _scrollDownTimer =
        Timer.periodic(const Duration(milliseconds: 16), (timer) {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final newOffset = (_scrollController.offset + 20).clamp(0.0, maxScroll);
      _scrollController.jumpTo(newOffset);
      if (newOffset >= maxScroll) {
        timer.cancel();
      }
    });
  }

  void _startScrollUp() {
    _scrollUpTimer?.cancel();
    _scrollUpTimer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      final newOffset = (_scrollController.offset - 20)
          .clamp(0.0, _scrollController.position.maxScrollExtent);
      _scrollController.jumpTo(newOffset);
      if (newOffset <= 0) {
        timer.cancel();
      }
    });
  }

  void _stopScroll() {
    _scrollDownTimer?.cancel();
    _scrollUpTimer?.cancel();
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

  Widget _buildDivider() {
    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(vertical: 0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.transparent,
            AppColors.secondaryAccent.withValues(alpha: 0.3),
            Colors.transparent,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Focus(
        autofocus: true,
        onKeyEvent: (node, event) {
          if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
            if (event is KeyDownEvent) {
              _startScrollDown();
              return KeyEventResult.handled;
            } else if (event is KeyUpEvent) {
              _stopScroll();
              return KeyEventResult.handled;
            }
          }
          if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
            if (event is KeyDownEvent) {
              _startScrollUp();
              return KeyEventResult.handled;
            } else if (event is KeyUpEvent) {
              _stopScroll();
              return KeyEventResult.handled;
            }
          }
          return KeyEventResult.ignored;
        },
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: AppColors.backgroundGradient,
              ),
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  physics: const BouncingScrollPhysics(),
                ),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  padding: const EdgeInsets.only(right: 16),
                  child: Column(
                    children: [
                      const SizedBox(height: 80),
                      Container(
                        key: _sectionKeys[0],
                        child: HeroSection(
                          onViewProjectsTap: () => _scrollToSection(4),
                          onContactTap: () => _scrollToSection(5),
                        ),
                      ),
                      _buildDivider(),
                      Container(
                        key: _sectionKeys[1],
                        child: const AboutSection(),
                      ),
                      _buildDivider(),
                      Container(
                        key: _sectionKeys[2],
                        child: const ExperienceSection(),
                      ),
                      _buildDivider(),
                      Container(
                        key: _sectionKeys[3],
                        child: const SkillsSection(),
                      ),
                      _buildDivider(),
                      Container(
                        key: _sectionKeys[4],
                        child: const ProjectsSection(),
                      ),
                      _buildDivider(),
                      Container(
                        key: _sectionKeys[5],
                        child: const ContactSection(),
                      ),
                    ],
                  ),
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
      ),
    );
  }
}
