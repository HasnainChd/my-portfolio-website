import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_website/utils/extension.dart';
import 'package:portfolio_website/widgets/animated_section.dart';
import '../utils/app_colors.dart';
import '../utils/app_constant.dart';
import '../utils/responsive.dart';

class AchievementsSection extends StatelessWidget {
  const AchievementsSection({super.key});

  static const List<_Achievement> _achievements = [
    _Achievement(
      icon: Icons.workspace_premium_rounded,
      title: 'Flutter Developer Intern',
      description: 'Completed internship at Nextpak Agile Solutions',
      year: '2025',
    ),
    _Achievement(
      icon: Icons.emoji_events_rounded,
      title: 'Flutter Developer',
      description: 'Promoted to full-time Flutter Developer role',
      year: '2025',
    ),
    _Achievement(
      icon: Icons.code_rounded,
      title: '5+ Projects Delivered',
      description: 'Successfully delivered multiple production apps',
      year: '2026',
    ),
    _Achievement(
      icon: Icons.school_rounded,
      title: 'Continuous Learning',
      description: 'Mastered Flutter, Firebase, and state management',
      year: 'Ongoing',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.value(
          context,
          mobile: AppConstants.paddingMedium,
          desktop: AppConstants.paddingXLarge * 2,
        ),
        vertical: Responsive.value(
          context,
          mobile: 60.0,
          desktop: 100.0,
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              AnimatedSection(
                child: Column(
                  children: [
                    _buildSectionLabel(context, 'ACHIEVEMENTS'),
                    16.height,
                    Text(
                      'My Milestones',
                      style: GoogleFonts.outfit(
                        fontSize: Responsive.value(
                          context,
                          mobile: 36.0,
                          tablet: 48.0,
                          desktop: 56.0,
                        ),
                        fontWeight: FontWeight.w700,
                        color: isDark
                            ? AppColors.darkForeground
                            : AppColors.lightForeground,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    16.height,
                    Container(
                      width: 100,
                      height: 4,
                      decoration: BoxDecoration(
                        gradient: AppColors.accentGradient,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    24.height,
                    SizedBox(
                      width: Responsive.value(
                        context,
                        mobile: double.infinity,
                        desktop: 700.0,
                      ),
                      child: Text(
                        'Key achievements and milestones in my professional journey as a Flutter developer.',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: Responsive.value(
                            context,
                            mobile: 16.0,
                            desktop: 18.0,
                          ),
                          color: isDark
                              ? AppColors.darkMutedText
                              : AppColors.lightMutedText,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              60.height,
              Wrap(
                spacing: Responsive.value(
                  context,
                  mobile: 20.0,
                  desktop: 24.0,
                ),
                runSpacing: Responsive.value(
                  context,
                  mobile: 20.0,
                  desktop: 24.0,
                ),
                alignment: WrapAlignment.center,
                children: _achievements.asMap().entries.map((entry) {
                  final index = entry.key;
                  final achievement = entry.value;
                  return AnimatedSection(
                    delay: Duration(milliseconds: 120 * index),
                    child: _AchievementCard(
                        achievement: achievement, isDark: isDark),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionLabel(BuildContext context, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primaryAccent.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: AppColors.primaryAccent.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: GoogleFonts.plusJakartaSans(
          color: AppColors.primaryAccent,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.5,
          fontSize: 13,
        ),
      ),
    );
  }
}

class _Achievement {
  final IconData icon;
  final String title;
  final String description;
  final String year;

  const _Achievement({
    required this.icon,
    required this.title,
    required this.description,
    required this.year,
  });
}

class _AchievementCard extends StatefulWidget {
  final _Achievement achievement;
  final bool isDark;

  const _AchievementCard({
    required this.achievement,
    required this.isDark,
  });

  @override
  State<_AchievementCard> createState() => _AchievementCardState();
}

class _AchievementCardState extends State<_AchievementCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: Responsive.value(
          context,
          mobile: double.infinity,
          tablet: 350.0,
          desktop: 560.0,
        ),
        padding: const EdgeInsets.all(28),
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
                    color: AppColors.primaryAccent.withValues(alpha: 0.15),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.primaryAccent.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.primaryAccent.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Icon(
                    widget.achievement.icon,
                    color: AppColors.primaryAccent,
                    size: 22,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryAccent.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: AppColors.primaryAccent.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Text(
                    widget.achievement.year,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryAccent,
                    ),
                  ),
                ),
              ],
            ),
            16.height,
            Text(
              widget.achievement.title,
              style: GoogleFonts.outfit(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: widget.isDark
                    ? AppColors.darkForeground
                    : AppColors.lightForeground,
              ),
            ),
            10.height,
            Text(
              widget.achievement.description,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                height: 1.6,
                color: widget.isDark
                    ? AppColors.darkMutedText
                    : AppColors.lightMutedText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
