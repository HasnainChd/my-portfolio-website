import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_styles.dart';
import '../utils/responsive.dart';

class SkillChip extends StatefulWidget {
  final String skillName;

  const SkillChip({
    super.key,
    required this.skillName,
  });

  @override
  State<SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<SkillChip> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.value(
            context,
            mobile: 20.0,
            desktop: 24.0,
          ),
          vertical: Responsive.value(
            context,
            mobile: 14.0,
            desktop: 16.0,
          ),
        ),
        decoration: BoxDecoration(
          gradient: isHovered ? AppColors.accentGradient.scale(0.2) : null,
          color: isHovered ? null : AppColors.cardBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isHovered
                ? AppColors.primaryAccent
                : AppColors.secondaryBackground,
            width: isHovered ? 2 : 1,
          ),
          boxShadow: isHovered
              ? [
                  BoxShadow(
                    color: AppColors.primaryAccent.withValues(alpha: 0.2),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Text(
          widget.skillName,
          style: AppTextStyles.body1.copyWith(
            fontSize: Responsive.value(
              context,
              mobile: 14.0,
              desktop: 16.0,
            ),
            color: isHovered ? AppColors.primaryAccent : AppColors.primaryText,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
