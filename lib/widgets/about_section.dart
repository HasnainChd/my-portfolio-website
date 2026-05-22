import 'package:flutter/material.dart';
import 'package:portfolio_website/utils/extension.dart';
import 'package:portfolio_website/widgets/animated_section.dart';
import '../utils/app_colors.dart';
import '../utils/app_constant.dart';
import '../utils/app_styles.dart';
import '../utils/responsive.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
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
          mobile: 60.0,
          desktop: 80.0,
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: AnimatedSection(
            child: Column(
              children: [
                // Section label
                _buildSectionLabel('ABOUT ME'),
                16.height,

                // Section title
                Text(
                  'Get To Know Me',
                  style: AppTextStyles.heading1.copyWith(
                    fontSize: Responsive.value(
                      context,
                      mobile: 36.0,
                      tablet: 48.0,
                      desktop: 56.0,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
                16.height,

                // Decorative line with gradient
                Container(
                  width: 100,
                  height: 4,
                  decoration: BoxDecoration(
                    gradient: AppColors.accentGradient,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                48.height,

                // About content
                SizedBox(
                  width: Responsive.value(
                    context,
                    mobile: double.infinity,
                    desktop: 900.0,
                  ),
                  child: Text(
                    'I\'m a Flutter Developer with 1.5+ years of professional experience building '
                    'cross-platform mobile applications. Previously at Nextpak Agile Solutions, Rawalpindi, '
                    'I contributed to real-world projects — building responsive UIs, integrating '
                    'REST APIs, working with Firebase & Supabase, and delivering apps on time.',
                    style: AppTextStyles.body1.copyWith(
                      fontSize: Responsive.value(
                        context,
                        mobile: 16.0,
                        desktop: 18.0,
                      ),
                      height: 1.8,
                      color: AppColors.secondaryText,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                40.height,

                // Stats/Highlights (optional)
                AnimatedSection(
                  delay: const Duration(milliseconds: 200),
                  child: Wrap(
                    spacing: Responsive.value(
                      context,
                      mobile: 16.0,
                      desktop: 40.0,
                    ),
                    runSpacing: 24,
                    alignment: WrapAlignment.center,
                    children: [
                      _buildStatCard(
                        context,
                        icon: Icons.code_rounded,
                        value: '1.5+',
                        label: 'Years Experience',
                      ),
                      _buildStatCard(
                        context,
                        icon: Icons.work_outline_rounded,
                        value: '2',
                        label: 'Projects Delivered',
                      ),
                      _buildStatCard(
                        context,
                        icon: Icons.emoji_events_outlined,
                        value: '5+',
                        label: 'Technologies Mastered',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        gradient: AppColors.accentGradient.scale(0.3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.primaryAccent.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: AppTextStyles.label.copyWith(
          color: AppColors.primaryAccent,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required IconData icon,
    required String value,
    required String label,
  }) {
    return _StatCard(
      icon: icon,
      value: value,
      label: label,
    );
  }
}

class _StatCard extends StatefulWidget {
  final IconData icon;
  final String value;
  final String label;

  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  State<_StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<_StatCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;
  late Animation<double> _shimmerAnimation;
  bool isHovered = false;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _shimmerAnimation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _shimmerController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => isHovered = true);
        _shimmerController.repeat();
      },
      onExit: (_) {
        setState(() => isHovered = false);
        _shimmerController.stop();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: Responsive.value(
          context,
          mobile: 140.0,
          desktop: 180.0,
        ),
        padding: EdgeInsets.all(
          Responsive.value(
            context,
            mobile: 20.0,
            desktop: 24.0,
          ),
        ),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isHovered
                ? AppColors.primaryAccent
                : AppColors.secondaryBackground,
            width: isHovered ? 2 : 1,
          ),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: AppColors.accentGradient.scale(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    widget.icon,
                    size: 28,
                    color: AppColors.primaryAccent,
                  ),
                ),
                16.height,
                Text(
                  widget.value,
                  style: AppTextStyles.heading2.copyWith(
                    fontSize: Responsive.value(
                      context,
                      mobile: 32.0,
                      desktop: 40.0,
                    ),
                    fontWeight: FontWeight.w800,
                  ),
                ),
                8.height,
                Text(
                  widget.label,
                  style: AppTextStyles.body2.copyWith(
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            if (isHovered)
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: AnimatedBuilder(
                    animation: _shimmerAnimation,
                    builder: (context, child) {
                      return ShaderMask(
                        shaderCallback: (bounds) {
                          return LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.transparent,
                              AppColors.primaryAccent.withValues(alpha: 0.3),
                              Colors.transparent,
                            ],
                            stops: [
                              0.0,
                              _shimmerAnimation.value.clamp(0.0, 1.0),
                              1.0,
                            ],
                          ).createShader(bounds);
                        },
                        blendMode: BlendMode.srcATop,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.primaryAccent
                                  .withValues(alpha: 0.5),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
