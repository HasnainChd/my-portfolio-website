import 'package:flutter/material.dart';
import 'package:portfolio_website/utils/extension.dart';
import 'package:portfolio_website/widgets/animated_section.dart';
import '../utils/app_colors.dart';
import '../utils/app_constant.dart';
import '../utils/app_styles.dart';
import '../utils/responsive.dart';
import '../utils/app_data.dart';
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
          mobile: 80.0,
          desktop: 120.0,
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
                    // Section label
                    _buildSectionLabel('MY SKILLS'),
                    16.height,

                    // Section title
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

                    // Decorative line
                    Container(
                      width: 100,
                      height: 4,
                      decoration: BoxDecoration(
                        gradient: AppColors.accentGradient,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    24.height,

                    // Subtitle
                    SizedBox(
                      width: Responsive.value(
                        context,
                        mobile: double.infinity,
                        desktop: 700.0,
                      ),
                      child: Text(
                        'Here are some of the technologies and tools I use to bring ideas to life',
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
              48.height,

              // Skills grid
              AnimatedSection(
                delay: const Duration(milliseconds: 200),
                child: Wrap(
                  spacing: Responsive.value(
                    context,
                    mobile: 12.0,
                    desktop: 16.0,
                  ),
                  runSpacing: Responsive.value(
                    context,
                    mobile: 12.0,
                    desktop: 16.0,
                  ),
                  alignment: WrapAlignment.center,
                  children: AppData.skills.map((skill) {
                    return SkillChip(skillName: skill.name);
                  }).toList(),
                ),
              ),
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
