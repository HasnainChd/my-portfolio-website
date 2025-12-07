import 'package:flutter/material.dart';
import 'package:portfolio_website/utils/extension.dart';
import '../utils/app_colors.dart';
import '../utils/app_constant.dart';
import '../utils/app_styles.dart';
import '../utils/responsive.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.value(
          context,
          mobile: AppConstants.paddingMedium,
          desktop: AppConstants.paddingXLarge,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Greeting text
            Text(
              'Hi, I\'m',
              style: AppTextStyles.body1.copyWith(
                color: AppColors.secondaryText,
                fontSize: Responsive.value(
                  context,
                  mobile: 16.0,
                  desktop: 20.0,
                ),
              ),
            ),
            AppConstants.paddingSmall.height,

            // Name - responsive font size
            Text(
              AppConstants.name,
              style: AppTextStyles.heading1.copyWith(
                fontSize: Responsive.value(
                  context,
                  mobile: 36.0,
                  tablet: 48.0,
                  desktop: 64.0,
                ),
              ),
              textAlign: TextAlign.center,
            ),
            AppConstants.paddingSmall.height,

            // Title with gradient
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [AppColors.primaryAccent, AppColors.secondaryAccent],
              ).createShader(bounds),
              child: Text(
                AppConstants.title,
                style: AppTextStyles.heading2.copyWith(
                  fontSize: Responsive.value(
                    context,
                    mobile: 24.0,
                    tablet: 32.0,
                    desktop: 40.0,
                  ),
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            AppConstants.paddingLarge.height,

            // Brief description - responsive width
            SizedBox(
              width: Responsive.value(
                context,
                mobile: MediaQuery.of(context).size.width * 0.9,
                tablet: 500.0,
                desktop: 600.0,
              ),
              child: Text(
                'I build beautiful and functional mobile applications using Flutter. Passionate about clean code and great user experiences.',
                style: AppTextStyles.body1.copyWith(
                  fontSize: Responsive.value(
                    context,
                    mobile: 14.0,
                    desktop: 16.0,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
