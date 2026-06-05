import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/project.dart';
import '../utils/app_colors.dart';
import '../utils/extension.dart';
import '../utils/responsive.dart';
import '../utils/url_launcher_helper.dart';
import 'project_details_modal.dart';

class ProjectCard extends StatefulWidget {
  final Project project;
  final bool isDark;

  const ProjectCard({
    super.key,
    required this.project,
    required this.isDark,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool isHovered = false;
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: widget.isDark ? AppColors.darkSurface : AppColors.lightSurface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isHovered
                ? AppColors.primaryAccent.withValues(alpha: 0.5)
                : (widget.isDark
                    ? AppColors.darkBorder
                    : AppColors.lightBorder),
            width: 1,
          ),
          boxShadow: isHovered
              ? [
                  BoxShadow(
                    color: AppColors.primaryAccent.withValues(alpha: 0.18),
                    blurRadius: 32,
                    offset: const Offset(0, 12),
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Screenshot slider ──────────────────────────────────────
            SizedBox(
              height: Responsive.value(context, mobile: 220.0, desktop: 280.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: widget.project.screenshotPaths.isNotEmpty
                    ? Stack(
                        children: [
                          PageView.builder(
                            controller: _pageController,
                            onPageChanged: (i) =>
                                setState(() => _currentPage = i),
                            itemCount: widget.project.screenshotPaths.length,
                            itemBuilder: (context, index) => Container(
                              color: const Color(0xFF0D1117),
                              child: Image.asset(
                                widget.project.screenshotPaths[index],
                                fit: BoxFit.contain,
                                errorBuilder: (_, __, ___) =>
                                    _buildPlaceholder(),
                              ),
                            ),
                          ),
                          if (widget.project.screenshotPaths.length > 1) ...[
                            // Left arrow
                            Positioned(
                              left: 8,
                              top: 0,
                              bottom: 0,
                              child: Center(
                                child: _buildNavButton(
                                  icon: Icons.chevron_left,
                                  onTap: () {
                                    if (_currentPage > 0) {
                                      _pageController.previousPage(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                            // Right arrow
                            Positioned(
                              right: 8,
                              top: 0,
                              bottom: 0,
                              child: Center(
                                child: _buildNavButton(
                                  icon: Icons.chevron_right,
                                  onTap: () {
                                    if (_currentPage <
                                        widget.project.screenshotPaths.length -
                                            1) {
                                      _pageController.nextPage(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                            // Dot indicators
                            Positioned(
                              bottom: 10,
                              left: 0,
                              right: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  widget.project.screenshotPaths.length,
                                  (i) => _buildDotIndicator(i == _currentPage),
                                ),
                              ),
                            ),
                          ],
                        ],
                      )
                    : _buildPlaceholder(),
              ),
            ),

            // ── Content ────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.project.title,
                    style: GoogleFonts.outfit(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: widget.isDark
                          ? AppColors.darkForeground
                          : AppColors.lightForeground,
                    ),
                  ),
                  12.height,
                  Text(
                    widget.project.description,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      height: 1.7,
                      color: widget.isDark
                          ? AppColors.darkMutedText
                          : AppColors.lightMutedText,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  16.height,
                  Text(
                    'TECH STACK',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5,
                      color: widget.isDark
                          ? AppColors.darkMutedText
                          : AppColors.lightMutedText,
                    ),
                  ),
                  10.height,
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: widget.project.technologies.map((tech) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.primaryAccent.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(
                            color:
                                AppColors.primaryAccent.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Text(
                          tech,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            color: AppColors.primaryAccent,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  24.height,
                  Row(
                    children: [
                      if (widget.project.playStoreUrl != null) ...[
                        Expanded(
                          child: _PlayStoreButton(
                            onTap: () async {
                              try {
                                await UrlLauncherHelper.launchURL(
                                    widget.project.playStoreUrl!);
                              } catch (e) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Could not open link: $e'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              }
                            },
                          ),
                        ),
                        12.width,
                      ],
                      Expanded(
                        child: _LinkButton(
                          icon: Icons.info_outline_rounded,
                          label: 'View Details',
                          onTap: () => showDialog(
                            context: context,
                            builder: (_) =>
                                ProjectDetailsModal(project: widget.project),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ).animate(target: isHovered ? 1 : 0).moveY(
            begin: 0,
            end: -10,
            duration: 300.ms,
            curve: Curves.easeOutCubic,
          ),
    );
  }

  Widget _buildPlaceholder() {
    final gradient = widget.project.title == 'Tealpot'
        ? const LinearGradient(
            colors: [
              AppColors.tealpotStart,
              AppColors.tealpotMiddle,
              AppColors.tealpotEnd,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
        : widget.project.title == 'ServicePro360'
            ? const LinearGradient(
                colors: [
                  AppColors.serviceProStart,
                  AppColors.serviceProMiddle,
                  AppColors.serviceProEnd,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : const LinearGradient(
                colors: [
                  AppColors.tealpotStart,
                  AppColors.tealpotMiddle,
                  AppColors.tealpotEnd,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              );

    return Container(
      decoration: BoxDecoration(gradient: gradient),
      child: Stack(
        children: [
          Center(
            child: Icon(
              Icons.flutter_dash,
              size: 72,
              color: Colors.white.withValues(alpha: 0.4),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Text(
              widget.project.title,
              style: GoogleFonts.outfit(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton(
      {required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.55),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 22),
      ),
    );
  }

  Widget _buildDotIndicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: isActive ? 16 : 6,
      height: 6,
      margin: const EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: isActive ? AppColors.primaryAccent : Colors.white38,
      ),
    );
  }
}

// ─── Buttons ──────────────────────────────────────────────────────────────────

class _LinkButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _LinkButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.primaryAccent.withValues(alpha: 0.4),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max, // ← was min
          children: [
            Icon(icon, size: 15, color: AppColors.primaryAccent),
            const SizedBox(width: 6),
            Flexible(
              // ← wrap in Flexible
              child: Text(
                label,
                style: GoogleFonts.plusJakartaSans(
                  color: AppColors.primaryAccent,
                  fontSize: 12, // ← 13→12
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlayStoreButton extends StatelessWidget {
  final VoidCallback onTap;
  const _PlayStoreButton({required this.onTap});

  // ─── _PlayStoreButton ────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF4CAF50),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max, // ← was min
          children: [
            const Icon(Icons.play_arrow_rounded, size: 15, color: Colors.white),
            const SizedBox(width: 6),
            Flexible(
              // ← wrap in Flexible
              child: Text(
                'Play Store',
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.white,
                  fontSize: 12, // ← 13→12
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
