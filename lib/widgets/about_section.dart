import 'package:flutter/material.dart';
import 'package:portfolio_website/utils/extension.dart';
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
          desktop: AppConstants.paddingXLarge,
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
              // Section title
              Text(
                'About Me',
                style: AppTextStyles.heading2.copyWith(
                  fontSize: Responsive.value(
                    context,
                    mobile: 28.0,
                    desktop: 36.0,
                  ),
                ),
              ),
              AppConstants.paddingMedium.height,

              // Underline decoration
              Container(
                width: 60,
                height: 4,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      AppColors.primaryAccent,
                      AppColors.secondaryAccent
                    ],
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              AppConstants.paddingXLarge.height,

              // About content
              Text(
                'I\'m a Junior Flutter Developer with a passion for creating beautiful, '
                'performant, and user-friendly mobile applications. Currently working at '
                '[Your Company Name], I focus on building cross-platform solutions that '
                'deliver great experiences on both iOS and Android.\n\n'
                'I love learning new technologies, writing clean code, and solving '
                'challenging problems. When I\'m not coding, you can find me exploring '
                'new Flutter packages, contributing to open source, or learning about '
                'the latest mobile development trends.',
                style: AppTextStyles.body1.copyWith(
                  fontSize: Responsive.value(
                    context,
                    mobile: 14.0,
                    desktop: 16.0,
                  ),
                  height: 1.8,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
