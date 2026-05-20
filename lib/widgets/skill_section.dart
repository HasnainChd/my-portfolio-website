import 'package:flutter/material.dart';

import '../models/skill_group.dart';
import '../utils/app_colors.dart';
import '../utils/app_constant.dart';
import '../utils/app_data.dart';
import '../utils/app_styles.dart';
import '../utils/extension.dart';
import '../utils/responsive.dart';
import 'animated_section.dart';
import 'skill_chip.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
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
          desktop: 80.0,
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
                    _buildSectionLabel('MY SKILLS'),
                    16.height,
                    Text(
                      'Technologies I Work With',
                      style: AppTextStyles.heading1.copyWith(
                        fontSize: Responsive.value(
                          context,
                          mobile: 36.0,
                          tablet: 48.0,
                          desktop: 56.0,
                        ),
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
                        'Skills grouped by how I use them across mobile, backend, architecture, quality, and shipping.',
                        style: AppTextStyles.body1.copyWith(
                          fontSize: Responsive.value(
                            context,
                            mobile: 16.0,
                            desktop: 18.0,
                          ),
                          color: AppColors.secondaryText,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              32.height,
              ...AppData.skillGroups.asMap().entries.map((entry) {
                final index = entry.key;
                final group = entry.value;
                return AnimatedSection(
                  delay: Duration(milliseconds: 120 * index),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: _SkillCategoryBlock(group: group),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        gradient: AppColors.accentGradient.scale(0.3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.primaryAccent.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: AppTextStyles.label.copyWith(
          color: AppColors.primaryAccent,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.5,
        ),
      ),
    );
  }
}

class _SkillCategoryBlock extends StatelessWidget {
  final SkillGroup group;

  const _SkillCategoryBlock({required this.group});

  Color _getCategoryColor(String title) {
    if (title.contains('Mobile')) {
      return AppColors.mobileCategoryTint;
    } else if (title.contains('Backend')) {
      return AppColors.backendCategoryTint;
    } else if (title.contains('State')) {
      return AppColors.stateCategoryTint;
    } else if (title.contains('Testing')) {
      return AppColors.testingCategoryTint;
    } else if (title.contains('Deployment')) {
      return AppColors.deploymentCategoryTint;
    }
    return AppColors.cardBackground;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _getCategoryColor(group.title),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.secondaryBackground,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: Responsive.value(
                  context,
                  mobile: 24.0,
                  desktop: 28.0,
                ),
                decoration: BoxDecoration(
                  gradient: AppColors.accentGradient,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              12.width,
              Text(
                group.title,
                style: AppTextStyles.heading4.copyWith(
                  fontSize: Responsive.value(
                    context,
                    mobile: 17.0,
                    desktop: 19.0,
                  ),
                  color: AppColors.primaryText,
                ),
              ),
            ],
          ),
          16.height,
          Wrap(
            spacing: Responsive.value(
              context,
              mobile: 12.0,
              desktop: 14.0,
            ),
            runSpacing: Responsive.value(
              context,
              mobile: 12.0,
              desktop: 14.0,
            ),
            children: group.skills
                .map(
                  (skill) => SkillChip(
                    skillName: skill.name,
                    icon: skill.icon,
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
