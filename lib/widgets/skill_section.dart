import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/skill_group.dart';
import '../utils/app_colors.dart';
import '../utils/app_constant.dart';
import '../utils/app_data.dart';
import '../utils/extension.dart';
import '../utils/responsive.dart';
import 'animated_section.dart';
import 'skill_chip.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              // ── Header ────────────────────────────────────────────────
              AnimatedSection(
                child: Column(
                  children: [
                    _buildSectionPill(),
                    24.height,
                    Text(
                      'Technologies I Work With',
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
                        'Skills grouped by how I use them across mobile, backend, architecture, quality, and shipping.',
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
              48.height,

              // ── 2-column skill grid ───────────────────────────────────
              _buildSkillGrid(context, isDark),
            ],
          ),
        ),
      ),
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
        'MY SKILLS',
        style: GoogleFonts.plusJakartaSans(
          color: AppColors.primaryAccent,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.5,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildSkillGrid(BuildContext context, bool isDark) {
    final isDesktop = Responsive.isDesktop(context);
    final groups = AppData.skillGroups;

    if (!isDesktop) {
      // Mobile: single column
      return Column(
        children: groups.asMap().entries.map((e) {
          return AnimatedSection(
            delay: Duration(milliseconds: 100 * e.key),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: _SkillCategoryBlock(group: e.value, isDark: isDark),
            ),
          );
        }).toList(),
      );
    }

    // Desktop: 2-column grid
    final rows = <Widget>[];
    for (int i = 0; i < groups.length; i += 2) {
      final left = groups[i];
      final right = i + 1 < groups.length ? groups[i + 1] : null;
      rows.add(
        AnimatedSection(
          delay: Duration(milliseconds: 100 * (i ~/ 2)),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _SkillCategoryBlock(group: left, isDark: isDark),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: right != null
                      ? _SkillCategoryBlock(group: right, isDark: isDark)
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Column(children: rows);
  }
}

// ─── Skill Category Block ─────────────────────────────────────────────────────

class _SkillCategoryBlock extends StatelessWidget {
  final SkillGroup group;
  final bool isDark;

  const _SkillCategoryBlock({required this.group, required this.isDark});

  @override
  Widget build(BuildContext context) {
    // Pick a subtle accent tint per category index
    final categoryColor = _categoryColor(group.title);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Category header ────────────────────────────────────────
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: categoryColor.withValues(alpha: isDark ? 0.12 : 0.08),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              border: Border(
                bottom: BorderSide(
                  color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                ),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: categoryColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _categoryIcon(group.title),
                    color: categoryColor,
                    size: 16,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  group.title.toUpperCase(),
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: categoryColor,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),

          // ── Skill chips ────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(20),
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: group.skills
                  .map((skill) => SkillChip(
                        skillName: skill.name,
                        icon: skill.icon,
                        isDark: isDark,
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Color _categoryColor(String title) {
    final t = title.toLowerCase();
    if (t.contains('mobile') || t.contains('flutter')) {
      return AppColors.mobileCategory;
    } else if (t.contains('backend') ||
        t.contains('api') ||
        t.contains('database')) {
      return AppColors.backendCategory;
    } else if (t.contains('state') || t.contains('architect')) {
      return AppColors.stateCategory;
    } else if (t.contains('test') || t.contains('quality')) {
      return AppColors.testingCategory;
    } else if (t.contains('deploy') ||
        t.contains('tool') ||
        t.contains('devops')) {
      return AppColors.deploymentCategory;
    }
    return AppColors.primaryAccent;
  }

  IconData _categoryIcon(String title) {
    final t = title.toLowerCase();
    if (t.contains('mobile') || t.contains('flutter')) {
      return Icons.phone_iphone_rounded;
    }
    if (t.contains('backend') || t.contains('api')) return Icons.dns_rounded;
    if (t.contains('database')) return Icons.storage_rounded;
    if (t.contains('state') || t.contains('architect')) {
      return Icons.account_tree_outlined;
    }
    if (t.contains('test') || t.contains('quality')) {
      return Icons.bug_report_outlined;
    }
    if (t.contains('deploy') || t.contains('tool')) {
      return Icons.rocket_launch_outlined;
    }
    return Icons.code_rounded;
  }
}
