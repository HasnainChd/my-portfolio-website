import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../utils/app_colors.dart';
import '../utils/app_constant.dart';
import '../utils/app_styles.dart';
import '../utils/extension.dart';
import '../utils/responsive.dart';

class _OpenToWorkIndicator extends StatefulWidget {
  const _OpenToWorkIndicator();

  @override
  State<_OpenToWorkIndicator> createState() => _OpenToWorkIndicatorState();
}

class _OpenToWorkIndicatorState extends State<_OpenToWorkIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
    _scaleAnimation = Tween<double>(begin: 1.0, end: 2.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _fadeAnimation = Tween<double>(begin: 0.8, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.successGreen.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.successGreen.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 16,
            height: 16,
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: AppColors.successGreen.withValues(
                            alpha: _fadeAnimation.value,
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                    );
                  },
                ),
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.successGreen,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'Open to Work',
            style: AppTextStyles.label.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.successGreen,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

class HeroSection extends StatelessWidget {
  final VoidCallback? onViewProjectsTap;
  final VoidCallback? onContactTap;

  const HeroSection({
    super.key,
    this.onViewProjectsTap,
    this.onContactTap,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = !Responsive.isDesktop(context);

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height - 80,
      ),
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
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: isMobile
              ? _buildMobileLayout(context)
              : _buildDesktopLayout(context),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 6,
          child: _buildTextContent(context),
        ),
        const SizedBox(width: 60),
        Expanded(
          flex: 4,
          child: _buildProfilePhoto(context),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        _buildProfilePhoto(context),
        40.height,
        _buildTextContent(context),
      ],
    );
  }

  Widget _buildTextContent(BuildContext context) {
    final isMobile = !Responsive.isDesktop(context);
    final titleFontSize = Responsive.value(
      context,
      mobile: 28.0,
      tablet: 40.0,
      desktop: 52.0,
    );
    final titleLineHeight = titleFontSize * 1.25;

    final titleStyle = AppTextStyles.heading1.copyWith(
      fontSize: titleFontSize,
      color: Colors.white,
      height: 1.15,
    );

    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const _OpenToWorkIndicator()
            .animate()
            .fadeIn(duration: 450.ms, curve: Curves.easeOut)
            .slideY(
                begin: 0.06,
                end: 0,
                duration: 450.ms,
                curve: Curves.easeOutCubic),
        16.height,
        Row(
          mainAxisSize: isMobile ? MainAxisSize.min : MainAxisSize.max,
          children: [
            Text(
              'WELCOME TO MY PORTFOLIO!',
              style: AppTextStyles.welcome.copyWith(
                fontSize: Responsive.value(
                  context,
                  mobile: 14.0,
                  desktop: 18.0,
                ),
                color: AppColors.secondaryText,
                letterSpacing: 2.0,
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              '👋',
              style: TextStyle(fontSize: 24),
            ),
          ],
        )
            .animate()
            .fadeIn(delay: 50.ms, duration: 450.ms, curve: Curves.easeOut)
            .slideY(
                begin: 0.06,
                end: 0,
                delay: 50.ms,
                duration: 450.ms,
                curve: Curves.easeOutCubic),
        20.height,
        Text(
          AppConstants.name,
          style: AppTextStyles.display.copyWith(
            fontSize: Responsive.value(
              context,
              mobile: 40.0,
              tablet: 56.0,
              desktop: 72.0,
            ),
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
        )
            .animate()
            .fadeIn(delay: 80.ms, duration: 550.ms, curve: Curves.easeOut)
            .slideY(
                begin: 0.12,
                end: 0,
                delay: 80.ms,
                duration: 550.ms,
                curve: Curves.easeOutCubic),
        16.height,
        ShaderMask(
          shaderCallback: (bounds) =>
              AppColors.accentGradient.createShader(bounds),
          blendMode: BlendMode.srcIn,
          child: SizedBox(
            height: titleLineHeight + 8,
            width: Responsive.value(
              context,
              mobile: double.infinity,
              desktop: 700.0,
            ),
            child: Align(
              alignment: isMobile ? Alignment.center : Alignment.centerLeft,
              child: DefaultTextStyle(
                style: titleStyle,
                textAlign: isMobile ? TextAlign.center : TextAlign.left,
                child: AnimatedTextKit(
                  repeatForever: true,
                  pause: const Duration(milliseconds: 1400),
                  animatedTexts: [
                    TyperAnimatedText(
                      'Flutter Developer',
                      textStyle: titleStyle,
                      speed: const Duration(milliseconds: 55),
                    ),
                    TyperAnimatedText(
                      'Mobile App Developer',
                      textStyle: titleStyle,
                      speed: const Duration(milliseconds: 55),
                    ),
                    TyperAnimatedText(
                      'Cross-Platform Developer',
                      textStyle: titleStyle,
                      speed: const Duration(milliseconds: 45),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
            .animate()
            .fadeIn(delay: 140.ms, duration: 500.ms, curve: Curves.easeOut)
            .slideY(
                begin: 0.1,
                end: 0,
                delay: 140.ms,
                duration: 500.ms,
                curve: Curves.easeOutCubic),
        28.height,
        SizedBox(
          width: Responsive.value(
            context,
            mobile: double.infinity,
            desktop: 600.0,
          ),
          child: Text(
            'I build beautiful and functional mobile applications using Flutter. '
            'Passionate about clean code and creating exceptional user experiences.',
            style: AppTextStyles.body1.copyWith(
              fontSize: Responsive.value(
                context,
                mobile: 16.0,
                desktop: 18.0,
              ),
              height: 1.7,
            ),
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
          ),
        )
            .animate()
            .fadeIn(delay: 220.ms, duration: 550.ms, curve: Curves.easeOut)
            .slideY(
                begin: 0.08,
                end: 0,
                delay: 220.ms,
                duration: 550.ms,
                curve: Curves.easeOutCubic),
        40.height,
        Wrap(
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          spacing: 16,
          runSpacing: 16,
          children: [
            _buildPrimaryButton(
              label: 'View Projects',
              onTap: onViewProjectsTap ?? () {},
            ),
            _buildSecondaryButton(
              label: 'Contact Me',
              onTap: onContactTap ?? () {},
            ),
          ],
        )
            .animate()
            .fadeIn(delay: 300.ms, duration: 550.ms, curve: Curves.easeOut)
            .slideY(
                begin: 0.1,
                end: 0,
                delay: 300.ms,
                duration: 550.ms,
                curve: Curves.easeOutCubic),
      ],
    );
  }

  Widget _buildProfilePhoto(BuildContext context) {
    final size = Responsive.value(
      context,
      mobile: 280.0,
      tablet: 350.0,
      desktop: 450.0,
    );

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: AppColors.accentGradient,
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryAccent.withValues(alpha: 0.3),
            blurRadius: 40,
            spreadRadius: 0,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(20),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Image.asset(
                  'assets/images/profile/avatar.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.primaryAccent.withValues(alpha: 0.3),
                            AppColors.secondaryAccent.withValues(alpha: 0.3),
                          ],
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.person_outline_rounded,
                          size: size * 0.4,
                          color: AppColors.secondaryText,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(delay: 180.ms, duration: 650.ms, curve: Curves.easeOut)
        .scale(
          begin: const Offset(0.92, 0.92),
          end: const Offset(1, 1),
          delay: 180.ms,
          duration: 650.ms,
          curve: Curves.easeOutCubic,
        );
  }

  Widget _buildPrimaryButton({
    required String label,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.buttonGradient,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryAccent.withValues(alpha: 0.4),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 16,
            ),
            child: Text(
              label,
              style: AppTextStyles.label.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryText,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSecondaryButton({
    required String label,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.primaryAccent,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 16,
            ),
            child: Text(
              label,
              style: AppTextStyles.label.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryAccent,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
