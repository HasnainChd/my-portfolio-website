import 'package:flutter/material.dart';
import 'package:portfolio_website/utils/extension.dart';
import '../models/project.dart';
import '../utils/app_colors.dart';
import '../utils/app_constant.dart';
import '../utils/app_styles.dart';
import '../utils/responsive.dart';

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

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.translationValues(0, isHovered ? -10 : 0, 0),
        child: Container(
          width: Responsive.value(
            context,
            mobile: double.infinity,
            tablet: 350.0,
            desktop: 380.0,
          ),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
            border: Border.all(
              color: isHovered
                  ? AppColors.primaryAccent.withValues(alpha: .5)
                  : AppColors.secondaryBackground,
              width: 1.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Project image placeholder
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: AppColors.secondaryBackground,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(AppConstants.radiusLarge),
                    topRight: Radius.circular(AppConstants.radiusLarge),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primaryAccent.withValues(alpha: .2),
                      AppColors.secondaryAccent.withValues(alpha: .2),
                    ],
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.code,
                    size: 60,
                    color: AppColors.secondaryText,
                  ),
                ),
              ),

              // Content
              Padding(
                padding: const EdgeInsets.all(AppConstants.paddingLarge),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      widget.project.title,
                      style: AppTextStyles.heading3.copyWith(
                        fontSize: 20,
                      ),
                    ),
                    AppConstants.paddingSmall.height,

                    // Description
                    Text(
                      widget.project.description,
                      style: AppTextStyles.body2.copyWith(
                        height: 1.6,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    AppConstants.paddingMedium.height,

                    // Technologies
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: widget.project.technologies.map((tech) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color:
                                AppColors.primaryAccent.withValues(alpha: .1),
                            borderRadius: BorderRadius.circular(
                              AppConstants.radiusSmall,
                            ),
                            border: Border.all(
                              color:
                                  AppColors.primaryAccent.withValues(alpha: .3),
                            ),
                          ),
                          child: Text(
                            tech,
                            style: AppTextStyles.body2.copyWith(
                              fontSize: 12,
                              color: AppColors.primaryAccent,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    AppConstants.paddingLarge.height,

                    // Links
                    Row(
                      children: [
                        if (widget.project.githubUrl != null)
                          _LinkButton(
                            icon: Icons.code,
                            label: 'Code',
                            onTap: () {
                              // Open GitHub URL
                            },
                          ),
                        if (widget.project.githubUrl != null &&
                            widget.project.liveUrl != null)
                          AppConstants.paddingMedium.width,
                        if (widget.project.liveUrl != null)
                          _LinkButton(
                            icon: Icons.launch,
                            label: 'Live Demo',
                            onTap: () {
                              // Open live URL
                            },
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
      borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primaryAccent),
          borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: AppColors.primaryAccent),
            const SizedBox(width: 6),
            Text(
              label,
              style: AppTextStyles.body2.copyWith(
                color: AppColors.primaryAccent,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
