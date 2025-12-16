import 'package:flutter/material.dart';
import 'package:portfolio_website/utils/extension.dart';
import '../utils/app_colors.dart';
import '../utils/app_constant.dart';
import '../utils/app_styles.dart';
import '../utils/responsive.dart';
import '../utils/app_data.dart';
import 'project_card.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

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
                'Featured Projects',
                style: AppTextStyles.heading2.copyWith(
                  fontSize: Responsive.value(
                    context,
                    mobile: 28.0,
                    desktop: 36.0,
                  ),
                ),
              ),
              AppConstants.paddingMedium.height,

              // Underline
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

              // Projects grid
              Wrap(
                spacing: AppConstants.paddingLarge,
                runSpacing: AppConstants.paddingLarge,
                alignment: WrapAlignment.center,
                children: AppData.projects.map((project) {
                  return ProjectCard(project: project);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
