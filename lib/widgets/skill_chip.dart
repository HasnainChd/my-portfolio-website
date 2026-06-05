import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_colors.dart';
import '../utils/responsive.dart';

class SkillChip extends StatefulWidget {
  final String skillName;
  final IconData icon;
  final bool isDark;

  const SkillChip({
    super.key,
    required this.skillName,
    required this.icon,
    required this.isDark,
  });

  @override
  State<SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<SkillChip> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.basic,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.value(context, mobile: 14.0, desktop: 16.0),
          vertical: Responsive.value(context, mobile: 8.0, desktop: 10.0),
        ),
        decoration: BoxDecoration(
          color: _hovered
              ? AppColors.primaryAccent
              : AppColors.primaryAccent.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: _hovered
                ? AppColors.primaryAccent
                : AppColors.primaryAccent.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                widget.icon,
                key: ValueKey(_hovered),
                size: Responsive.value(context, mobile: 14.0, desktop: 16.0),
                color: _hovered ? Colors.white : AppColors.primaryAccent,
              ),
            ),
            SizedBox(
                width: Responsive.value(context, mobile: 7.0, desktop: 8.0)),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                color: _hovered ? Colors.white : AppColors.primaryAccent,
                fontWeight: FontWeight.w500,
              ),
              child: Text(widget.skillName),
            ),
          ],
        ),
      ),
    );
  }
}
