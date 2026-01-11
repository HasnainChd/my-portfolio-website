import 'package:flutter/material.dart';
import '../models/project.dart';
import '../utils/app_colors.dart';
import '../utils/app_styles.dart';
import '../utils/extension.dart';
import '../utils/responsive.dart';
import '../utils/url_launcher_helper.dart';

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
        duration: const Duration(milliseconds: 400),
        transform: Matrix4.translationValues(0, isHovered ? -12 : 0, 0),
        child: Container(
          width: Responsive.value(
            context,
            mobile: double.infinity,
            tablet: 380.0,
            desktop: 400.0,
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
              // Project image
              Container(
                height: 240,
                decoration: BoxDecoration(
                  color: AppColors.secondaryBackground,
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
                  child: AnimatedScale(
                    scale: isHovered ? 1.05 : 1.0,
                    duration: const Duration(milliseconds: 400),
                    child: widget.project.imageUrl != null
                        ? (widget.project.isAssetImage
                            ? Image.asset(
                                widget.project.imageUrl!,
                                width: double.infinity,
                                height: 240,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return _buildPlaceholder();
                                },
                              )
                            : Image.network(
                                widget.project.imageUrl!,
                                width: double.infinity,
                                height: 240,
                                fit: BoxFit.cover,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return _buildPlaceholder();
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return _buildPlaceholder();
                                },
                              ))
                        : _buildPlaceholder(),
                  ),
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
                    20.height,

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
                        if (widget.project.githubUrl != null)
                          Expanded(
                            child: _LinkButton(
                              icon: Icons.code_rounded,
                              label: 'View Code',
                              onTap: () async {
                                if (widget.project.githubUrl == null ||
                                    widget.project.githubUrl!.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('GitHub link not available'),
                                      backgroundColor:
                                          AppColors.secondaryAccent,
                                    ),
                                  );
                                  return;
                                }

                                try {
                                  await UrlLauncherHelper.launchURL(
                                      widget.project.githubUrl!);
                                } catch (e) {
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
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
                        if (widget.project.githubUrl != null &&
                            widget.project.liveUrl != null)
                          12.width,
                        if (widget.project.liveUrl != null)
                          Expanded(
                            child: _LinkButton(
                              icon: Icons.launch_rounded,
                              label: 'Live Demo',
                              onTap: () async {
                                if (widget.project.liveUrl == null ||
                                    widget.project.liveUrl!.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Live demo not available'),
                                      backgroundColor:
                                          AppColors.secondaryAccent,
                                    ),
                                  );
                                  return;
                                }

                                try {
                                  await UrlLauncherHelper.launchURL(
                                      widget.project.liveUrl!);
                                } catch (e) {
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
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

  Widget _buildPlaceholder() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryAccent.withValues(alpha: 0.2),
            AppColors.secondaryAccent.withValues(alpha: 0.2),
          ],
        ),
      ),
      child: const Center(
        child: Icon(
          Icons.image_outlined,
          size: 80,
          color: AppColors.secondaryText,
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
