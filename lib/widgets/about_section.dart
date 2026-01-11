import 'package:flutter/material.dart';
import 'package:portfolio_website/utils/extension.dart';
import 'package:portfolio_website/widgets/animated_section.dart';
import '../utils/app_colors.dart';
import '../utils/app_constant.dart';
import '../utils/app_styles.dart';
import '../utils/responsive.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

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
          child: AnimatedSection(
            child: Column(
              children: [
                // Section label
                _buildSectionLabel('ABOUT ME'),
                16.height,

                // Section title
                Text(
                  'Get To Know Me',
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

                // Decorative line with gradient
                Container(
                  width: 100,
                  height: 4,
                  decoration: BoxDecoration(
                    gradient: AppColors.accentGradient,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                48.height,

                // About content
                SizedBox(
                  width: Responsive.value(
                    context,
                    mobile: double.infinity,
                    desktop: 900.0,
                  ),
                  child: Text(
                    'I\'m a Junior Flutter Developer with a passion for creating beautiful, '
                    'performant, and user-friendly mobile applications. Currently working at '
                    'NextPak Agile Solutions, I focus on building cross-platform solutions that '
                    'deliver great experiences on both iOS and Android.\n\n'
                    'I love learning new technologies, writing clean code, and solving '
                    'challenging problems. When I\'m not coding, you can find me exploring '
                    'new Flutter packages, contributing to open source, or learning about '
                    'the latest mobile development trends.',
                    style: AppTextStyles.body1.copyWith(
                      fontSize: Responsive.value(
                        context,
                        mobile: 16.0,
                        desktop: 18.0,
                      ),
                      height: 1.8,
                      color: AppColors.secondaryText,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                60.height,

                // Stats/Highlights (optional)
                AnimatedSection(
                  delay: const Duration(milliseconds: 200),
                  child: Wrap(
                    spacing: Responsive.value(
                      context,
                      mobile: 16.0,
                      desktop: 40.0,
                    ),
                    runSpacing: 24,
                    alignment: WrapAlignment.center,
                    children: [
                      _buildStatCard(
                        context,
                        icon: Icons.code_rounded,
                        value: '1+',
                        label: 'Year Experience',
                      ),
                      _buildStatCard(
                        context,
                        icon: Icons.work_outline_rounded,
                        value: '10+',
                        label: 'Projects Completed',
                      ),
                      _buildStatCard(
                        context,
                        icon: Icons.emoji_events_outlined,
                        value: '5+',
                        label: 'Happy Clients',
                      ),
                    ],
                  ),
                ),
              ],
            ),
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

  Widget _buildStatCard(
    BuildContext context, {
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Container(
      width: Responsive.value(
        context,
        mobile: 140.0,
        desktop: 180.0,
      ),
      padding: EdgeInsets.all(
        Responsive.value(
          context,
          mobile: 20.0,
          desktop: 24.0,
        ),
      ),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.secondaryBackground,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: AppColors.accentGradient.scale(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              size: 28,
              color: AppColors.primaryAccent,
            ),
          ),
          16.height,
          Text(
            value,
            style: AppTextStyles.heading2.copyWith(
              fontSize: Responsive.value(
                context,
                mobile: 32.0,
                desktop: 40.0,
              ),
              fontWeight: FontWeight.w800,
            ),
          ),
          8.height,
          Text(
            label,
            style: AppTextStyles.body2.copyWith(
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
