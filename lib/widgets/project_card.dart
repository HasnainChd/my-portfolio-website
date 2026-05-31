import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../models/project.dart';
import '../utils/app_colors.dart';
import '../utils/app_styles.dart';
import '../utils/extension.dart';
import '../utils/responsive.dart';
import '../utils/url_launcher_helper.dart';
import 'project_details_modal.dart';

class ProjectCard extends StatefulWidget {
  final Project project;

  const ProjectCard({
    super.key,
    required this.project,
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
          duration: const Duration(milliseconds: 400),
          child: Container(
            width: Responsive.value(
              context,
              mobile: double.infinity,
              tablet: 350.0,
              desktop: 380.0,
            ),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isHovered
                    ? AppColors.primaryAccent.withValues(alpha: 0.5)
                    : AppColors.secondaryBackground,
                width: 1,
              ),
              boxShadow: isHovered
                  ? [
                      BoxShadow(
                        color: AppColors.primaryAccent.withValues(alpha: 0.2),
                        blurRadius: 30,
                        spreadRadius: 0,
                        offset: const Offset(0, 15),
                      ),
                    ]
                  : null,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Project image slider
                Container(
                  height: Responsive.value(
                    context,
                    mobile: 220.0,
                    desktop: 320.0,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D1117),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    child: widget.project.screenshotPaths.isNotEmpty
                        ? Stack(
                            children: [
                              PageView.builder(
                                controller: _pageController,
                                onPageChanged: (index) {
                                  setState(() => _currentPage = index);
                                },
                                itemCount:
                                    widget.project.screenshotPaths.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    color: const Color(0xFF0D1117),
                                    child: Image.asset(
                                      widget.project.screenshotPaths[index],
                                      width: double.infinity,
                                      height: Responsive.value(
                                        context,
                                        mobile: 220.0,
                                        desktop: 280.0,
                                      ),
                                      fit: BoxFit.contain,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return _buildPlaceholder();
                                      },
                                    ),
                                  );
                                },
                              ),
                              // Left arrow
                              if (widget.project.screenshotPaths.length > 1)
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
                                            duration: const Duration(
                                                milliseconds: 300),
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
                                  right: 8,
                                  top: 0,
                                  bottom: 0,
                                  child: Center(
                                    child: _buildNavButton(
                                      icon: Icons.chevron_right,
                                      onTap: () {
                                        if (_currentPage <
                                            widget.project.screenshotPaths
                                                    .length -
                                                1) {
                                          _pageController.nextPage(
                                            duration: const Duration(
                                                milliseconds: 300),
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
                                  bottom: 12,
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
                          )
                        : _buildPlaceholder(),
                  ),
                ),

                // Content
                Padding(
                  padding: const EdgeInsets.all(28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        widget.project.title,
                        style: AppTextStyles.heading3.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      12.height,

                      // Description
                      Text(
                        widget.project.description,
                        style: AppTextStyles.body2.copyWith(
                          fontSize: 15,
                          height: 1.7,
                          color: AppColors.secondaryText,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      16.height,
                      Text(
                        'Tech stack',
                        style: AppTextStyles.caption.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.2,
                          color: AppColors.tertiaryText,
                        ),
                      ),
                      10.height,

                      // Technologies
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
                              gradient: AppColors.accentGradient.scale(0.15),
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

                      // Links
                      Row(
                        children: [
                          // Play Store button for Tealpot only
                          if (widget.project.playStoreUrl != null)
                            Expanded(
                              child: _PlayStoreButton(
                                onTap: () async {
                                  if (widget.project.playStoreUrl == null ||
                                      widget.project.playStoreUrl!.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
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
                                          content:
                                              Text('Could not open link: $e'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  }
                                },
                              ),
                            ),
                          if (widget.project.playStoreUrl != null) 12.width,
                          Expanded(
                            child: _LinkButton(
                              icon: Icons.info_outline_rounded,
                              label: 'View Details',
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => ProjectDetailsModal(
                                    project: widget.project,
                                  ),
                                );
                              },
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
        ).animate(target: isHovered ? 1 : 0).moveY(
              begin: 0,
              end: -12,
              duration: 350.ms,
              curve: Curves.easeOutCubic,
            ));
  }

  Widget _buildPlaceholder() {
    // Determine gradient based on project title
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
      decoration: BoxDecoration(
        gradient: gradient,
      ),
      child: Stack(
        children: [
          Center(
            child: Icon(
              Icons.flutter_dash,
              size: 80,
              color: AppColors.primaryAccent.withValues(alpha: 0.8),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Text(
              widget.project.title,
              style: AppTextStyles.heading3.copyWith(
                color: AppColors.primaryText,
                fontWeight: FontWeight.w700,
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
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.5),
        shape: BoxShape.circle,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
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
              icon,
              size: 18,
              color: AppColors.primaryAccent,
            ),
            const SizedBox(width: 8),
            Text(
              label,
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
