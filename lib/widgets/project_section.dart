import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_website/utils/extension.dart';
import 'package:portfolio_website/widgets/animated_section.dart';
import '../utils/app_colors.dart';
import '../utils/app_constant.dart';
import '../utils/responsive.dart';
import '../utils/app_data.dart';
import 'project_card.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isDesktop = Responsive.isDesktop(context);

    return Container(
      width: double.infinity,
      color: AppColors.background(context),
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.value(
          context,
          mobile: AppConstants.paddingMedium,
          desktop: AppConstants.paddingXLarge * 2,
        ),
        vertical: Responsive.value(context, mobile: 60.0, desktop: 100.0),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: Column(
            children: [
              // ── Header ────────────────────────────────────────────────
              AnimatedSection(
                child: Column(
                  children: [
                    _buildSectionPill(),
                    24.height,
                    Text(
                      'Featured Projects',
                      style: GoogleFonts.outfit(
                        fontSize: Responsive.value(
                          context,
                          mobile: 36.0,
                          tablet: 48.0,
                          desktop: 52.0,
                        ),
                        fontWeight: FontWeight.w700,
                        color: AppColors.foreground(context),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    12.height,
                    Container(
                      width: 64,
                      height: 4,
                      decoration: BoxDecoration(
                        gradient: AppColors.accentGradient,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    20.height,
                    SizedBox(
                      width: Responsive.value(
                        context,
                        mobile: double.infinity,
                        desktop: 640.0,
                      ),
                      child: Text(
                        'Here are some of my recent projects that showcase my skills and experience.',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: Responsive.value(
                            context,
                            mobile: 15.0,
                            desktop: 17.0,
                          ),
                          color: AppColors.mutedText(context),
                          height: 1.6,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              60.height,

              // ── Projects grid ─────────────────────────────────────────
              isDesktop
                  ? _buildDesktopGrid(context, isDark)
                  : _buildMobileList(context, isDark),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopGrid(BuildContext context, bool isDark) {
    final projects = AppData.projects;
    // 3-column grid
    final rows = <Widget>[];
    for (int i = 0; i < projects.length; i += 3) {
      final rowItems = projects.sublist(i, (i + 3).clamp(0, projects.length));
      rows.add(
        AnimatedSection(
          delay: Duration(milliseconds: 150 * (i ~/ 3)),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int j = 0; j < 3; j++) ...[
                  if (j > 0) const SizedBox(width: 24),
                  Expanded(
                    child: j < rowItems.length
                        ? ProjectCard(project: rowItems[j], isDark: isDark)
                        : const SizedBox.shrink(),
                  ),
                ],
              ],
            ),
          ),
        ),
      );
    }
    return Column(children: rows);
  }

  Widget _buildMobileList(BuildContext context, bool isDark) {
    return Column(
      children: AppData.projects.asMap().entries.map((e) {
        return AnimatedSection(
          delay: Duration(milliseconds: 150 * e.key),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: ProjectCard(project: e.value, isDark: isDark),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSectionPill() {
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
        'MY WORK',
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
