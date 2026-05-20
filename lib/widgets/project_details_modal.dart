import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/project.dart';
import '../utils/app_colors.dart';
import '../utils/app_styles.dart';
import '../utils/extension.dart';
import '../utils/responsive.dart';
import '../utils/url_launcher_helper.dart';

class ProjectDetailsModal extends StatefulWidget {
  final Project project;

  const ProjectDetailsModal({
    super.key,
    required this.project,
  });

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
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: Stack(
        children: [
          // Dark overlay background
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              color: Colors.black.withValues(alpha: 0.85),
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          // Modal content
          Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: 900,
                maxHeight: MediaQuery.of(context).size.height * 0.9,
              ),
              margin: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF0D1B2A),
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Close button
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
                                color: AppColors.secondaryBackground,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.close,
                                color: AppColors.primaryText,
                                size: 20,
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
                            // Project header
                            Text(
                              widget.project.title,
                              style: AppTextStyles.heading1.copyWith(
                                fontSize: Responsive.value(
                                  context,
                                  mobile: 28.0,
                                  desktop: 36.0,
                                ),
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            12.height,
                            // Tagline
                            if (widget.project.tagline != null)
                              Text(
                                widget.project.tagline!,
                                style: AppTextStyles.body1.copyWith(
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic,
                                  color: AppColors.primaryAccent,
                                ),
                              ),
                            16.height,
                            // Tech stack
                            Text(
                              'Tech Stack',
                              style: AppTextStyles.caption.copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.2,
                                color: AppColors.tertiaryText,
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
                                    gradient:
                                        AppColors.accentGradient.scale(0.15),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: AppColors.primaryAccent
                                          .withValues(alpha: 0.3),
                                    ),
                                  ),
                                  child: Text(
                                    tech,
                                    style: AppTextStyles.caption.copyWith(
                                      fontSize: 13,
                                      color: AppColors.primaryAccent,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            24.height,
                            // Description
                            Text(
                              'Description',
                              style: AppTextStyles.heading3.copyWith(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            12.height,
                            Text(
                              widget.project.description,
                              style: AppTextStyles.body1.copyWith(
                                fontSize: 15,
                                height: 1.7,
                                color: AppColors.secondaryText,
                              ),
                            ),
                            24.height,
                            // Key features
                            Text(
                              'Key Features',
                              style: AppTextStyles.heading3.copyWith(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            12.height,
                            ...widget.project.keyFeatures.map((feature) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      '• ',
                                      style: TextStyle(
                                        color: AppColors.primaryAccent,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        feature,
                                        style: AppTextStyles.body1.copyWith(
                                          fontSize: 15,
                                          height: 1.7,
                                          color: AppColors.secondaryText,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                            32.height,
                            // Action buttons
                            Row(
                              children: [
                                // Play Store button for Tealpot
                                if (widget.project.playStoreUrl != null)
                                  Expanded(
                                    child: _PlayStoreButton(
                                      onTap: () async {
                                        if (widget.project.playStoreUrl ==
                                                null ||
                                            widget.project.playStoreUrl!
                                                .isEmpty) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  'Play Store link not available'),
                                              backgroundColor:
                                                  AppColors.secondaryAccent,
                                            ),
                                          );
                                          return;
                                        }

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
                                if (widget.project.playStoreUrl != null)
                                  12.width,
                                // Close button
                                Expanded(
                                  child: _CloseButton(
                                    onTap: () => Navigator.pop(context),
                                  ),
                                ),
                              ],
                            ),
                            16.height,
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ).animate().fadeIn(duration: 300.ms).scale(
                  begin: const Offset(0.9, 0.9),
                  end: const Offset(1, 1),
                  duration: 300.ms,
                  curve: Curves.easeOutCubic,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageSlider(BuildContext context) {
    final sliderHeight = Responsive.value(
      context,
      mobile: 250.0,
      desktop: 400.0,
    );

    return Container(
      height: sliderHeight,
      color: const Color(0xFF0D1117),
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            itemCount: widget.project.screenshotPaths.length,
            itemBuilder: (context, index) {
              return Container(
                color: const Color(0xFF0D1117),
                child: Image.asset(
                  widget.project.screenshotPaths[index],
                  width: double.infinity,
                  height: sliderHeight,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(
                        Icons.broken_image,
                        color: AppColors.secondaryText,
                        size: 48,
                      ),
                    );
                  },
                ),
              );
            },
          ),
          // Left arrow
          if (widget.project.screenshotPaths.length > 1)
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
          // Right arrow
          if (widget.project.screenshotPaths.length > 1)
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
          // Dot indicators
          if (widget.project.screenshotPaths.length > 1)
            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.project.screenshotPaths.length,
                  (index) => _buildDotIndicator(
                    isActive: index == _currentPage,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildNavButton(
      {required IconData icon, required VoidCallback onTap}) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.5),
        shape: BoxShape.circle,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Icon(
          icon,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }

  Widget _buildDotIndicator({required bool isActive}) {
    return Container(
      width: 8,
      height: 8,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? AppColors.primaryAccent : Colors.grey,
      ),
    );
  }
}

class _PlayStoreButton extends StatelessWidget {
  final VoidCallback onTap;

  const _PlayStoreButton({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF4CAF50),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.play_arrow_rounded,
              size: 18,
              color: Colors.white,
            ),
            const SizedBox(width: 8),
            Text(
              'Play Store',
              style: AppTextStyles.label.copyWith(
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

  const _CloseButton({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.primaryAccent.withValues(alpha: 0.5),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.close_rounded,
              size: 18,
              color: AppColors.primaryAccent,
            ),
            const SizedBox(width: 8),
            Text(
              'Close',
              style: AppTextStyles.label.copyWith(
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
