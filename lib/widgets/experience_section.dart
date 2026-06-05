import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_colors.dart';
import '../utils/extension.dart';
import '../utils/app_constant.dart';
import '../utils/responsive.dart';
import 'animated_section.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  static const List<_ExperienceEntry> _entries = [
    _ExperienceEntry(
      role: 'Flutter Developer Intern',
      company: 'Nextpak Agile Solutions',
      location: 'Rawalpindi, Pakistan',
      period: 'Feb 2025 – Jul 2025',
      type: 'Internship',
      descriptions: [
        'Learned Flutter development in a professional environment',
        'Assisted in building UI components and screens',
        'Worked with REST APIs and Firebase integration',
        'Participated in code reviews and team meetings',
      ],
    ),
    _ExperienceEntry(
      role: 'Flutter Developer',
      company: 'Nextpak Agile Solutions',
      location: 'Rawalpindi, Pakistan',
      period: 'Aug 2025 – May 2026',
      type: 'Full-time',
      descriptions: [
        'Developed and maintained cross-platform mobile apps',
        'Worked on Tealpot and ServicePro360 projects end-to-end',
        'Implemented state management using Provider, GetX, Riverpod',
        'Wrote unit tests and golden tests for quality assurance',
        'Integrated REST APIs and handled app deployment on Play Store',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
          constraints: const BoxConstraints(maxWidth: 800),
          child: AnimatedSection(
            child: Column(
              children: [
                // ── Section label ─────────────────────────────────────
                _buildSectionPill(),
                24.height,

                // ── Heading ───────────────────────────────────────────
                Text(
                  'Work Experience',
                  style: GoogleFonts.outfit(
                    fontSize: Responsive.value(
                      context,
                      mobile: 36.0,
                      tablet: 48.0,
                      desktop: 52.0,
                    ),
                    fontWeight: FontWeight.w700,
                    color: AppColors.foreground(context),
                  ),
                  textAlign: TextAlign.center,
                ),
                12.height,
                Text(
                  'My professional journey so far',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    color: AppColors.mutedText(context),
                  ),
                  textAlign: TextAlign.center,
                ),
                16.height,

                // Accent underline
                Container(
                  width: 64,
                  height: 4,
                  decoration: BoxDecoration(
                    gradient: AppColors.accentGradient,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                56.height,

                // ── Timeline ──────────────────────────────────────────
                AnimatedSection(
                  delay: const Duration(milliseconds: 200),
                  child: _Timeline(entries: _entries, isDark: isDark),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionPill() {
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
        'EXPERIENCE',
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

// ─── Data class ───────────────────────────────────────────────────────────────

class _ExperienceEntry {
  final String role;
  final String company;
  final String location;
  final String period;
  final String type;
  final List<String> descriptions;

  const _ExperienceEntry({
    required this.role,
    required this.company,
    required this.location,
    required this.period,
    required this.type,
    required this.descriptions,
  });
}

// ─── Timeline ─────────────────────────────────────────────────────────────────

class _Timeline extends StatelessWidget {
  final List<_ExperienceEntry> entries;
  final bool isDark;

  const _Timeline({required this.entries, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Vertical line
        Positioned(
          left: 15,
          top: 16,
          bottom: 16,
          child: Container(
            width: 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.primaryAccent.withValues(alpha: 0.6),
                  AppColors.accentLight.withValues(alpha: 0.2),
                ],
              ),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 0; i < entries.length; i++) ...[
              _TimelineRow(entry: entries[i], isDark: isDark),
              if (i < entries.length - 1) 32.height,
            ],
          ],
        ),
      ],
    );
  }
}

// ─── Timeline Row ─────────────────────────────────────────────────────────────

class _TimelineRow extends StatelessWidget {
  final _ExperienceEntry entry;
  final bool isDark;

  const _TimelineRow({required this.entry, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dot with ring
          Column(
            children: [
              const SizedBox(height: 20),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryAccent.withValues(alpha: 0.12),
                  border: Border.all(
                    color: AppColors.primaryAccent,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryAccent,
                    ),
                  ),
                ),
              ),
            ],
          ),
          20.width,

          // Card
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Role + type badge
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          entry.role,
                          style: GoogleFonts.outfit(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: isDark
                                ? AppColors.darkForeground
                                : AppColors.lightForeground,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryAccent.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(
                            color:
                                AppColors.primaryAccent.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Text(
                          entry.type,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryAccent,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  10.height,

                  // Company
                  ShaderMask(
                    shaderCallback: (bounds) =>
                        AppColors.accentGradient.createShader(bounds),
                    blendMode: BlendMode.srcIn,
                    child: Text(
                      entry.company,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  10.height,

                  // Location + period
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 13,
                        color: isDark
                            ? AppColors.darkMutedText
                            : AppColors.lightMutedText,
                      ),
                      4.width,
                      Text(
                        entry.location,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13,
                          color: isDark
                              ? AppColors.darkMutedText
                              : AppColors.lightMutedText,
                        ),
                      ),
                      16.width,
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 13,
                        color: isDark
                            ? AppColors.darkMutedText
                            : AppColors.lightMutedText,
                      ),
                      4.width,
                      Text(
                        entry.period,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13,
                          color: isDark
                              ? AppColors.darkMutedText
                              : AppColors.lightMutedText,
                        ),
                      ),
                    ],
                  ),
                  20.height,

                  // Divider
                  Container(
                    height: 1,
                    color:
                        isDark ? AppColors.darkBorder : AppColors.lightBorder,
                  ),
                  16.height,

                  // Bullet points
                  ...entry.descriptions.map(
                    (desc) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 7),
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryAccent,
                            ),
                          ),
                          12.width,
                          Expanded(
                            child: Text(
                              desc,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 14,
                                color: isDark
                                    ? AppColors.darkMutedText
                                    : AppColors.lightMutedText,
                                height: 1.6,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
