import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_website/utils/extension.dart';
import 'package:portfolio_website/widgets/animated_section.dart';
import '../utils/app_colors.dart';
import '../utils/app_constant.dart';
import '../utils/responsive.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  static const List<_Service> _services = [
    _Service(
      icon: Icons.phone_android_rounded,
      title: 'Mobile App Development',
      description:
          'Building cross-platform mobile applications using Flutter for iOS and Android.',
    ),
    _Service(
      icon: Icons.web_rounded,
      title: 'Web Development',
      description:
          'Creating responsive web applications using Flutter Web with modern UI/UX.',
    ),
    _Service(
      icon: Icons.cloud_rounded,
      title: 'Backend Integration',
      description:
          'Integrating REST APIs, Firebase, and Supabase for robust backend solutions.',
    ),
    _Service(
      icon: Icons.design_services_rounded,
      title: 'UI/UX Design',
      description:
          'Designing beautiful and intuitive user interfaces with focus on user experience.',
    ),
    _Service(
      icon: Icons.speed_rounded,
      title: 'Performance Optimization',
      description:
          'Optimizing app performance for smooth animations and fast load times.',
    ),
    _Service(
      icon: Icons.bug_report_rounded,
      title: 'Testing & Debugging',
      description:
          'Writing unit tests and debugging to ensure high-quality code delivery.',
    ),
  ];

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
          mobile: 60.0,
          desktop: 100.0,
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              AnimatedSection(
                child: Column(
                  children: [
                    _buildSectionLabel(context, 'SERVICES'),
                    16.height,
                    Text(
                      'What I Offer',
                      style: GoogleFonts.outfit(
                        fontSize: Responsive.value(
                          context,
                          mobile: 36.0,
                          tablet: 48.0,
                          desktop: 56.0,
                        ),
                        fontWeight: FontWeight.w700,
                        color: isDark
                            ? AppColors.darkForeground
                            : AppColors.lightForeground,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    16.height,
                    Container(
                      width: 100,
                      height: 4,
                      decoration: BoxDecoration(
                        gradient: AppColors.accentGradient,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    24.height,
                    SizedBox(
                      width: Responsive.value(
                        context,
                        mobile: double.infinity,
                        desktop: 700.0,
                      ),
                      child: Text(
                        'Professional services to help bring your ideas to life with modern technology and best practices.',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: Responsive.value(
                            context,
                            mobile: 16.0,
                            desktop: 18.0,
                          ),
                          color: isDark
                              ? AppColors.darkMutedText
                              : AppColors.lightMutedText,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              60.height,
              Wrap(
                spacing: Responsive.value(
                  context,
                  mobile: 20.0,
                  desktop: 24.0,
                ),
                runSpacing: Responsive.value(
                  context,
                  mobile: 20.0,
                  desktop: 24.0,
                ),
                alignment: WrapAlignment.center,
                children: _services.asMap().entries.map((entry) {
                  final index = entry.key;
                  final service = entry.value;
                  return AnimatedSection(
                    delay: Duration(milliseconds: 120 * index),
                    child: _ServiceCard(service: service, isDark: isDark),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionLabel(BuildContext context, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primaryAccent.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: AppColors.primaryAccent.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: GoogleFonts.plusJakartaSans(
          color: AppColors.primaryAccent,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.5,
          fontSize: 13,
        ),
      ),
    );
  }
}

class _Service {
  final IconData icon;
  final String title;
  final String description;

  const _Service({
    required this.icon,
    required this.title,
    required this.description,
  });
}

class _ServiceCard extends StatefulWidget {
  final _Service service;
  final bool isDark;

  const _ServiceCard({
    required this.service,
    required this.isDark,
  });

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: Responsive.value(
          context,
          mobile: double.infinity,
          tablet: 350.0,
          desktop: 380.0,
        ),
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: widget.isDark ? AppColors.darkSurface : AppColors.lightSurface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isHovered
                ? AppColors.primaryAccent.withValues(alpha: 0.5)
                : (widget.isDark
                    ? AppColors.darkBorder
                    : AppColors.lightBorder),
            width: 1,
          ),
          boxShadow: isHovered
              ? [
                  BoxShadow(
                    color: AppColors.primaryAccent.withValues(alpha: 0.15),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.primaryAccent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.primaryAccent.withValues(alpha: 0.2),
                ),
              ),
              child: Icon(
                widget.service.icon,
                color: AppColors.primaryAccent,
                size: 22,
              ),
            ),
            16.height,
            Text(
              widget.service.title,
              style: GoogleFonts.outfit(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: widget.isDark
                    ? AppColors.darkForeground
                    : AppColors.lightForeground,
              ),
            ),
            12.height,
            Text(
              widget.service.description,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                height: 1.6,
                color: widget.isDark
                    ? AppColors.darkMutedText
                    : AppColors.lightMutedText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
