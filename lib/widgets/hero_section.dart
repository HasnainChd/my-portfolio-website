import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/app_colors.dart';
import '../utils/app_constant.dart';
import '../utils/extension.dart';
import '../utils/responsive.dart';

// ─── Open to Work Badge ───────────────────────────────────────────────────────

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
    _scaleAnimation = Tween<double>(begin: 1.0, end: 2.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _fadeAnimation = Tween<double>(begin: 0.7, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
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
        color: AppColors.primaryAccent.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: AppColors.primaryAccent.withValues(alpha: 0.3),
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
                  builder: (context, child) => Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Opacity(
                      opacity: _fadeAnimation.value,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: Color(0xFF4CAF50),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFF4CAF50),
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'Open to Work',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryAccent,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Hero Section ─────────────────────────────────────────────────────────────

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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height - 80,
      ),
      color: AppColors.background(context),
      child: Stack(
        children: [
          // Decorative glow — top left
          Positioned(
            top: -120,
            left: -120,
            child: Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.primaryAccent
                        .withValues(alpha: isDark ? 0.18 : 0.10),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          // Decorative glow — bottom right
          Positioned(
            bottom: -120,
            right: -120,
            child: Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.accentLight
                        .withValues(alpha: isDark ? 0.15 : 0.08),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          // Content
          Padding(
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
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: 6, child: _buildTextContent(context)),
        const SizedBox(width: 60),
        Expanded(flex: 4, child: _buildProfilePhoto(context)),
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Open to work badge
        const _OpenToWorkIndicator()
            .animate()
            .fadeIn(duration: 450.ms, curve: Curves.easeOut)
            .slideY(
                begin: 0.06,
                end: 0,
                duration: 450.ms,
                curve: Curves.easeOutCubic),

        24.height,

        // Headline
        Column(
          crossAxisAlignment:
              isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            Text(
              "Hi, I'm",
              style: GoogleFonts.outfit(
                fontSize: Responsive.value(context,
                    mobile: 40.0, tablet: 52.0, desktop: 64.0),
                fontWeight: FontWeight.w800,
                color: AppColors.foreground(context),
                height: 1.1,
              ),
            )
                .animate()
                .fadeIn(delay: 50.ms, duration: 450.ms, curve: Curves.easeOut)
                .slideY(
                    begin: 0.06,
                    end: 0,
                    delay: 50.ms,
                    duration: 450.ms,
                    curve: Curves.easeOutCubic),
            ShaderMask(
              shaderCallback: (bounds) =>
                  AppColors.accentGradient.createShader(bounds),
              blendMode: BlendMode.srcIn,
              child: Text(
                'Muhammad Hasnain',
                style: GoogleFonts.outfit(
                  fontSize: Responsive.value(context,
                      mobile: 40.0, tablet: 52.0, desktop: 64.0),
                  fontWeight: FontWeight.w800,
                  height: 1.15,
                  color: Colors.white, // required for ShaderMask to work
                ),
              ),
            )
                .animate()
                .fadeIn(delay: 80.ms, duration: 450.ms, curve: Curves.easeOut)
                .slideY(
                    begin: 0.06,
                    end: 0,
                    delay: 80.ms,
                    duration: 450.ms,
                    curve: Curves.easeOutCubic),
          ],
        ),

        24.height,

        // Animated rotating subtitle
        // REPLACE WITH:
        SizedBox(
          height: 40,
          child: Row(
            mainAxisAlignment:
                isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
            children: [
              AnimatedTextKit(
                repeatForever: true,
                pause: const Duration(milliseconds: 1800),
                animatedTexts: [
                  TyperAnimatedText(
                    'Flutter Developer',
                    textStyle: GoogleFonts.plusJakartaSans(
                      fontSize: Responsive.value(context,
                          mobile: 18.0, desktop: 22.0),
                      fontWeight: FontWeight.w500,
                      color: AppColors.mutedText(context),
                    ),
                    speed: const Duration(milliseconds: 60),
                  ),
                  TyperAnimatedText(
                    'Mobile App Architect',
                    textStyle: GoogleFonts.plusJakartaSans(
                      fontSize: Responsive.value(context,
                          mobile: 18.0, desktop: 22.0),
                      fontWeight: FontWeight.w500,
                      color: AppColors.mutedText(context),
                    ),
                    speed: const Duration(milliseconds: 60),
                  ),
                  TyperAnimatedText(
                    'Cross-Platform Engineer',
                    textStyle: GoogleFonts.plusJakartaSans(
                      fontSize: Responsive.value(context,
                          mobile: 18.0, desktop: 22.0),
                      fontWeight: FontWeight.w500,
                      color: AppColors.mutedText(context),
                    ),
                    speed: const Duration(milliseconds: 60),
                  ),
                ],
              ),
            ],
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

        24.height,

        // Bio
        SizedBox(
          width: Responsive.value(context,
              mobile: double.infinity, desktop: 520.0),
          child: Text(
            'Crafting premium mobile experiences with Flutter. I build technically '
            'sophisticated, high-performance applications that users love.',
            style: GoogleFonts.plusJakartaSans(
              fontSize: Responsive.value(context, mobile: 16.0, desktop: 18.0),
              fontWeight: FontWeight.w400,
              color: AppColors.mutedText(context),
              height: 1.6,
            ),
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
          ),
        )
            .animate()
            .fadeIn(delay: 180.ms, duration: 550.ms, curve: Curves.easeOut)
            .slideY(
                begin: 0.08,
                end: 0,
                delay: 180.ms,
                duration: 550.ms,
                curve: Curves.easeOutCubic),

        40.height,

        // CTA buttons
        Wrap(
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          spacing: 16,
          runSpacing: 16,
          children: [
            _buildPrimaryButton(
              label: 'View Projects →',
              onTap: onViewProjectsTap ?? () {},
            ),
            _buildSecondaryButton(
              label: 'Contact Me',
              onTap: onContactTap ?? () {},
              isDark: isDark,
            ),
          ],
        )
            .animate()
            .fadeIn(delay: 220.ms, duration: 550.ms, curve: Curves.easeOut)
            .slideY(
                begin: 0.1,
                end: 0,
                delay: 220.ms,
                duration: 550.ms,
                curve: Curves.easeOutCubic),

        32.height,

        // Social icons
        Wrap(
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          spacing: 12,
          children: [
            _buildSocialIcon(
              icon: Icons.terminal_rounded,
              tooltip: 'GitHub',
              url: 'https://github.com/Muhammad-Hasnain67',
              isDark: isDark,
            ),
            _buildSocialIcon(
              icon: Icons.business_center_outlined,
              tooltip: 'LinkedIn',
              url: 'https://linkedin.com/in/muhammad-hasnain309',
              isDark: isDark,
            ),
            _buildSocialIcon(
              icon: Icons.alternate_email_rounded,
              tooltip: 'Email',
              url: 'mailto:naindev309@gmail.com',
              isDark: isDark,
            ),
          ],
        )
            .animate()
            .fadeIn(delay: 260.ms, duration: 550.ms, curve: Curves.easeOut)
            .slideY(
                begin: 0.1,
                end: 0,
                delay: 260.ms,
                duration: 550.ms,
                curve: Curves.easeOutCubic),
      ],
    );
  }

  Widget _buildProfilePhoto(BuildContext context) {
    final size = Responsive.value(
      context,
      mobile: 240.0,
      tablet: 280.0,
      desktop: 320.0,
    );

    return Stack(
      alignment: Alignment.center,
      children: [
        _PulsingGlow(size: size),
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.primaryAccent.withValues(alpha: 0.25),
              width: 2,
            ),
          ),
          child: ClipOval(
            child: Image.asset(
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
                        AppColors.accentLight.withValues(alpha: 0.3),
                      ],
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.person_outline_rounded,
                      size: size * 0.4,
                      color: AppColors.primaryAccent,
                    ),
                  ),
                );
              },
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
            ),
      ],
    );
  }

  Widget _buildPrimaryButton({
    required String label,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.buttonGradient,
        borderRadius: BorderRadius.circular(999),
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
          borderRadius: BorderRadius.circular(999),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: Text(
              label,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                letterSpacing: 0.5,
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
    required bool isDark,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryAccent, width: 2),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(999),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: Text(
              label,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryAccent,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialIcon({
    required IconData icon,
    required String tooltip,
    required String url,
    required bool isDark,
  }) {
    return Tooltip(
      message: tooltip,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: _SocialIconButton(icon: icon, url: url, isDark: isDark),
      ),
    );
  }
}

// Stateful wrapper for social icon hover effect
class _SocialIconButton extends StatefulWidget {
  final IconData icon;
  final String url;
  final bool isDark;

  const _SocialIconButton({
    required this.icon,
    required this.url,
    required this.isDark,
  });

  @override
  State<_SocialIconButton> createState() => _SocialIconButtonState();
}

class _SocialIconButtonState extends State<_SocialIconButton> {
  bool _hovered = false;

  Future<void> _launchUrl() async {
    final uri = Uri.parse(widget.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: _launchUrl,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: _hovered
                ? AppColors.primaryAccent.withValues(alpha: 0.12)
                : (widget.isDark
                    ? AppColors.darkSurface
                    : AppColors.lightSurface),
            shape: BoxShape.circle,
            border: Border.all(
              color: _hovered
                  ? AppColors.primaryAccent.withValues(alpha: 0.5)
                  : (widget.isDark
                      ? AppColors.darkBorder
                      : AppColors.lightBorder),
              width: 1,
            ),
          ),
          child: Icon(
            widget.icon,
            color: _hovered
                ? AppColors.primaryAccent
                : (widget.isDark
                    ? AppColors.darkMutedText
                    : AppColors.lightMutedText),
            size: 20,
          ),
        ),
      ),
    );
  }
}

// ─── Pulsing Glow ─────────────────────────────────────────────────────────────

class _PulsingGlow extends StatefulWidget {
  final double size;
  const _PulsingGlow({required this.size});

  @override
  State<_PulsingGlow> createState() => _PulsingGlowState();
}

class _PulsingGlowState extends State<_PulsingGlow>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.25).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _opacityAnimation = Tween<double>(begin: 0.35, end: 0.0).animate(
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
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Transform.scale(
        scale: _scaleAnimation.value,
        child: Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                AppColors.primaryAccent
                    .withValues(alpha: _opacityAnimation.value),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
