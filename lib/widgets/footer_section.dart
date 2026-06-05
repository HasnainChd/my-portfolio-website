import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_website/utils/extension.dart';
import '../utils/app_colors.dart';
import '../utils/app_constant.dart';
import '../utils/responsive.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
          mobile: 40.0,
          desktop: 60.0,
        ),
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          Text(
            '© ${DateTime.now().year} ${AppConstants.name}. All rights reserved.',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 15,
              color:
                  isDark ? AppColors.darkMutedText : AppColors.lightMutedText,
            ),
            textAlign: TextAlign.center,
          ),
          12.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Built with',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  color: isDark
                      ? AppColors.darkMutedText
                      : AppColors.lightMutedText,
                ),
              ),
              const SizedBox(width: 6),
              ShaderMask(
                shaderCallback: (bounds) =>
                    AppColors.accentGradient.createShader(bounds),
                child: Text(
                  'Flutter',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 6),
              const Text('💙', style: TextStyle(fontSize: 16)),
            ],
          ),
        ],
      ),
    );
  }
}
