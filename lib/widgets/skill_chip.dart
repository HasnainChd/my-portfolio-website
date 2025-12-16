import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_constant.dart';
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
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.value(
            context,
            mobile: 16.0,
            desktop: 20.0,
          ),
          vertical: Responsive.value(
            context,
            mobile: 10.0,
            desktop: 12.0,
          ),
        ),
        decoration: BoxDecoration(
          color: isHovered
              ? AppColors.primaryAccent.withValues(alpha: .1)
              : AppColors.cardBackground,
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          border: Border.all(
            color: isHovered
                ? AppColors.primaryAccent
                : AppColors.secondaryBackground,
            width: 1.5,
          ),
        ),
        child: Text(
          widget.skillName,
          style: AppTextStyles.body1.copyWith(
            fontSize: Responsive.value(
              context,
              mobile: 13.0,
              desktop: 15.0,
            ),
            color: isHovered ? AppColors.primaryAccent : AppColors.primaryText,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
