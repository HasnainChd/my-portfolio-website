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
import '../widgets/services_section.dart';
import '../widgets/achievements_section.dart';
import '../widgets/footer_section.dart';
import '../widgets/nav_bar.dart';
import '../widgets/scroll_to_top_button.dart';

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

  final List<GlobalKey> _sectionKeys = List.generate(9, (index) => GlobalKey());

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
      if (newOffset >= maxScroll) timer.cancel();
    });
  }

  void _startScrollUp() {
    _scrollUpTimer?.cancel();
    _scrollUpTimer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      final newOffset = (_scrollController.offset - 20)
          .clamp(0.0, _scrollController.position.maxScrollExtent);
      _scrollController.jumpTo(newOffset);
      if (newOffset <= 0) timer.cancel();
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
          if (_currentSection != i) setState(() => _currentSection = i);
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
      final targetScroll = (_scrollController.offset + position - 80)
          .clamp(0.0, _scrollController.position.maxScrollExtent);
      _scrollController.animateTo(
        targetScroll,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  Widget _buildDivider(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      height: 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.transparent,
            isDark
                ? AppColors.primaryAccent.withValues(alpha: 0.2)
                : AppColors.primaryAccent.withValues(alpha: 0.15),
            Colors.transparent,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: AppColors.background(context),
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
            // ── Background ──────────────────────────────────────────────────
            Positioned.fill(
              child: isDark
                  ? Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF0B0F1A),
                            Color(0xFF0E1420),
                            Color(0xFF0B0F1A),
                          ],
                        ),
                      ),
                    )
                  : Container(color: AppColors.lightBackground),
            ),

            // ── Scrollable content ───────────────────────────────────────────
            ScrollConfiguration(
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
                        onViewProjectsTap: () => _scrollToSection(6),
                        onContactTap: () => _scrollToSection(7),
                      ),
                    ),
                    _buildDivider(context),
                    Container(
                        key: _sectionKeys[1], child: const AboutSection()),
                    _buildDivider(context),
                    Container(
                        key: _sectionKeys[2], child: const ExperienceSection()),
                    _buildDivider(context),
                    Container(
                        key: _sectionKeys[3], child: const SkillsSection()),
                    _buildDivider(context),
                    Container(
                        key: _sectionKeys[4], child: const ServicesSection()),
                    _buildDivider(context),
                    Container(
                        key: _sectionKeys[5],
                        child: const AchievementsSection()),
                    _buildDivider(context),
                    Container(
                        key: _sectionKeys[6], child: const ProjectsSection()),
                    _buildDivider(context),
                    Container(
                        key: _sectionKeys[7], child: const ContactSection()),
                    _buildDivider(context),
                    Container(
                        key: _sectionKeys[8], child: const FooterSection()),
                  ],
                ),
              ),
            ),

            // ── Sticky navbar ────────────────────────────────────────────────
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: NavBar(
                currentIndex: _currentSection,
                onNavItemTapped: _scrollToSection,
              ),
            ),

            // ── Scroll-to-top button ─────────────────────────────────────────
            Positioned(
              bottom: 32,
              right: 32,
              child: ScrollToTopButton(scrollController: _scrollController),
            ),
          ],
        ),
      ),
    );
  }
}
