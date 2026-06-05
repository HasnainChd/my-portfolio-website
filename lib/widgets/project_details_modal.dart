import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/project.dart';
import '../utils/app_colors.dart';
import '../utils/extension.dart';
import '../utils/responsive.dart';
import '../utils/url_launcher_helper.dart';

class ProjectDetailsModal extends StatefulWidget {
  final Project project;

  const ProjectDetailsModal({super.key, required this.project});

  @override
  State<ProjectDetailsModal> createState() => _ProjectDetailsModalState();
}

class _ProjectDetailsModalState extends State<ProjectDetailsModal> {
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: Stack(
        children: [
          // Scrim
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              color: Colors.black.withValues(alpha: 0.80),
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          // Modal
          Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: 900,
                maxHeight: MediaQuery.of(context).size.height * 0.9,
              ),
              margin: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.surface(context),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.border(context), width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isDark ? 0.5 : 0.2),
                    blurRadius: 60,
                    offset: const Offset(0, 20),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Close button row
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: AppColors.primaryAccent
                                    .withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.primaryAccent
                                      .withValues(alpha: 0.3),
                                ),
                              ),
                              child: const Icon(
                                Icons.close_rounded,
                                color: AppColors.primaryAccent,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Image slider
                      if (widget.project.screenshotPaths.isNotEmpty)
                        _buildImageSlider(context),

                      // Content
                      Padding(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title
                            Text(
                              widget.project.title,
                              style: GoogleFonts.outfit(
                                fontSize: Responsive.value(
                                  context,
                                  mobile: 28.0,
                                  desktop: 36.0,
                                ),
                                fontWeight: FontWeight.w700,
                                color: AppColors.foreground(context),
                              ),
                            ),
                            12.height,

                            // Tagline
                            if (widget.project.tagline != null) ...[
                              Text(
                                widget.project.tagline!,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic,
                                  color: AppColors.primaryAccent,
                                ),
                              ),
                              16.height,
                            ],

                            // Tech stack
                            Text(
                              'TECH STACK',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.5,
                                color: AppColors.mutedText(context),
                              ),
                            ),
                            10.height,
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: widget.project.technologies.map((tech) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryAccent
                                        .withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: AppColors.primaryAccent
                                          .withValues(alpha: 0.3),
                                    ),
                                  ),
                                  child: Text(
                                    tech,
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 13,
                                      color: AppColors.primaryAccent,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            28.height,

                            // Description heading
                            Text(
                              'Description',
                              style: GoogleFonts.outfit(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: AppColors.foreground(context),
                              ),
                            ),
                            12.height,
                            Text(
                              widget.project.description,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 15,
                                height: 1.7,
                                color: AppColors.mutedText(context),
                              ),
                            ),
                            28.height,

                            // Key features
                            Text(
                              'Key Features',
                              style: GoogleFonts.outfit(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: AppColors.foreground(context),
                              ),
                            ),
                            12.height,
                            ...widget.project.keyFeatures.map(
                              (feature) => Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(top: 7),
                                      width: 6,
                                      height: 6,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.primaryAccent,
                                      ),
                                    ),
                                    12.width,
                                    Expanded(
                                      child: Text(
                                        feature,
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 15,
                                          height: 1.7,
                                          color: AppColors.mutedText(context),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            32.height,

                            // Action buttons
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
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    'Could not open link: $e'),
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
                                  child: _CloseButton(
                                    onTap: () => Navigator.pop(context),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ).animate().fadeIn(duration: 250.ms).scale(
                  begin: const Offset(0.92, 0.92),
                  end: const Offset(1, 1),
                  duration: 250.ms,
                  curve: Curves.easeOutCubic,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageSlider(BuildContext context) {
    final sliderHeight =
        Responsive.value(context, mobile: 250.0, desktop: 420.0);

    return Container(
      height: sliderHeight,
      color: const Color(0xFF0D1117),
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (i) => setState(() => _currentPage = i),
            itemCount: widget.project.screenshotPaths.length,
            itemBuilder: (context, index) => Container(
              color: const Color(0xFF0D1117),
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Image.asset(
                widget.project.screenshotPaths[index],
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => const Center(
                  child: Icon(Icons.broken_image_outlined,
                      color: Colors.white38, size: 48),
                ),
              ),
            ),
          ),
          if (widget.project.screenshotPaths.length > 1) ...[
            Positioned(
              left: 16,
              top: 0,
              bottom: 0,
              child: Center(
                child: _buildNavButton(
                  icon: Icons.chevron_left,
                  onTap: () {
                    if (_currentPage > 0) {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                ),
              ),
            ),
            Positioned(
              right: 16,
              top: 0,
              bottom: 0,
              child: Center(
                child: _buildNavButton(
                  icon: Icons.chevron_right,
                  onTap: () {
                    if (_currentPage <
                        widget.project.screenshotPaths.length - 1) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 14,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.project.screenshotPaths.length,
                  (i) => AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: i == _currentPage ? 16 : 6,
                    height: 6,
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: i == _currentPage
                          ? AppColors.primaryAccent
                          : Colors.white38,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildNavButton(
      {required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.5),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 24),
      ),
    );
  }
}

// ─── Buttons ──────────────────────────────────────────────────────────────────

class _PlayStoreButton extends StatelessWidget {
  final VoidCallback onTap;
  const _PlayStoreButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF4CAF50),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.play_arrow_rounded, size: 18, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              'Play Store',
              style: GoogleFonts.plusJakartaSans(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CloseButton extends StatelessWidget {
  final VoidCallback onTap;
  const _CloseButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          border:
              Border.all(color: AppColors.primaryAccent.withValues(alpha: 0.4)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.close_rounded, size: 18, color: AppColors.primaryAccent),
            const SizedBox(width: 8),
            Text(
              'Close',
              style: GoogleFonts.plusJakartaSans(
                color: AppColors.primaryAccent,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
