import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_website/utils/extension.dart';
import 'package:portfolio_website/widgets/animated_section.dart';
import '../utils/app_colors.dart';
import '../utils/app_constant.dart';
import '../utils/responsive.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = !Responsive.isDesktop(context);

    return Container(
      width: double.infinity,
      color: AppColors.background(context),
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.value(
          context,
          mobile: AppConstants.paddingMedium,
          desktop: AppConstants.paddingXLarge * 2,
        ),
        vertical: Responsive.value(context, mobile: 60.0, desktop: 100.0),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: AnimatedSection(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Section label ──────────────────────────────────────
                _buildSectionLabel(context),
                32.height,
                // ── Main content ───────────────────────────────────────
                isMobile
                    ? _buildMobileLayout(context, isDark)
                    : _buildDesktopLayout(context, isDark),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionLabel(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 3,
          height: 20,
          decoration: BoxDecoration(
            gradient: AppColors.accentGradient,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          '// ABOUT',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryAccent,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context, bool isDark) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 5, child: _buildAboutCard(context, isDark)),
        const SizedBox(width: 60),
        Expanded(flex: 7, child: _buildRightColumn(context, isDark)),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context, bool isDark) {
    return Column(
      children: [
        _buildAboutCard(context, isDark),
        40.height,
        _buildRightColumn(context, isDark),
      ],
    );
  }

  Widget _buildAboutCard(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.surface(context),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.border(context),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // MH Badge with decorative corners
          _buildMonogramBadge(),
          24.height,

          // Heading
          Text(
            'About Me',
            style: GoogleFonts.outfit(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: AppColors.foreground(context),
            ),
          ),
          16.height,

          // Bio
          Text(
            "I'm a Flutter Developer with 1.5+ years of professional experience building "
            "cross-platform mobile applications. Previously at Nextpak Agile Solutions, Rawalpindi, "
            "I contributed to real-world projects — building responsive UIs, integrating "
            "REST APIs, working with Firebase & Supabase, and delivering apps on time.",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: AppColors.mutedText(context),
              height: 1.7,
            ),
          ),
          28.height,

          // Info rows
          _buildInfoRow(
            icon: Icons.location_on_outlined,
            text: 'Rawalpindi, Pakistan',
            context: context,
          ),
          12.height,
          _buildInfoRow(
            icon: Icons.alternate_email_rounded,
            text: 'naindev309@gmail.com',
            context: context,
          ),
          12.height,
          _buildInfoRow(
            icon: Icons.work_outline_rounded,
            text: 'Available for freelance',
            context: context,
          ),
          12.height,
          _buildInfoRow(
            icon: Icons.language_rounded,
            text: 'English, Urdu',
            context: context,
          ),
        ],
      ),
    );
  }

  Widget _buildMonogramBadge() {
    return SizedBox(
      width: 90,
      height: 90,
      child: Stack(
        children: [
          // Main badge
          Container(
            width: 72,
            height: 72,
            margin: const EdgeInsets.only(top: 9, left: 9),
            decoration: BoxDecoration(
              gradient: AppColors.accentGradient,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Text(
                'MH',
                style: GoogleFonts.outfit(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          // Top-left corner accent
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                border: const Border(
                  top: BorderSide(color: AppColors.primaryAccent, width: 2),
                  left: BorderSide(color: AppColors.primaryAccent, width: 2),
                ),
                borderRadius:
                    const BorderRadius.only(topLeft: Radius.circular(4)),
              ),
            ),
          ),
          // Bottom-right corner accent
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                border: const Border(
                  bottom: BorderSide(color: AppColors.accentLight, width: 2),
                  right: BorderSide(color: AppColors.accentLight, width: 2),
                ),
                borderRadius:
                    const BorderRadius.only(bottomRight: Radius.circular(4)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String text,
    required BuildContext context,
  }) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: AppColors.primaryAccent.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: AppColors.primaryAccent, size: 16),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.mutedText(context),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRightColumn(BuildContext context, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'At a Glance',
          style: GoogleFonts.outfit(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: AppColors.foreground(context),
          ),
        ),
        8.height,
        Text(
          'Numbers that reflect my journey',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 15,
            color: AppColors.mutedText(context),
          ),
        ),
        32.height,
        _buildStatsGrid(context, isDark),
        48.height,
        _buildPassionBlock(context),
      ],
    );
  }

  Widget _buildStatsGrid(BuildContext context, bool isDark) {
    final stats = [
      (Icons.code_rounded, '1.5+', 'Years Experience'),
      (Icons.work_outline_rounded, '5+', 'Projects Delivered'),
      (Icons.emoji_events_outlined, '10+', 'Technologies Mastered'),
      (Icons.star_outline_rounded, '100%', 'Client Satisfaction'),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = (constraints.maxWidth - 24) / 2;
        return Wrap(
          spacing: 24,
          runSpacing: 24,
          children: stats
              .map((s) => _buildStatCard(
                    context,
                    icon: s.$1,
                    value: s.$2,
                    label: s.$3,
                    isDark: isDark,
                    width: cardWidth,
                  ))
              .toList(),
        );
      },
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required IconData icon,
    required String value,
    required String label,
    required bool isDark,
    required double width,
  }) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface(context),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border(context), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.primaryAccent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.primaryAccent, size: 18),
          ),
          20.height,
          ShaderMask(
            shaderCallback: (bounds) =>
                AppColors.accentGradient.createShader(bounds),
            blendMode: BlendMode.srcIn,
            child: Text(
              value,
              style: GoogleFonts.outfit(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
          6.height,
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.mutedText(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPassionBlock(BuildContext context) {
    final items = [
      (
        Icons.phone_iphone_rounded,
        'Mobile First',
        'Building for iOS & Android simultaneously'
      ),
      (
        Icons.bolt_rounded,
        'Performance',
        'Optimized apps with smooth 60fps animations'
      ),
      (
        Icons.palette_outlined,
        'Clean UI',
        'Pixel-perfect, accessible design implementation'
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What drives me',
          style: GoogleFonts.outfit(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.foreground(context),
          ),
        ),
        20.height,
        ...items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.primaryAccent.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:
                        Icon(item.$1, color: AppColors.primaryAccent, size: 20),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.$2,
                          style: GoogleFonts.outfit(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.foreground(context),
                          ),
                        ),
                        4.height,
                        Text(
                          item.$3,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13,
                            color: AppColors.mutedText(context),
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
