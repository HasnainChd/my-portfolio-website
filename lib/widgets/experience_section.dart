import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/extension.dart';
import '../utils/app_constant.dart';
import '../utils/app_styles.dart';
import '../utils/responsive.dart';
import 'animated_section.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  static const List<_ExperienceEntry> _entries = [
    _ExperienceEntry(
      role: 'Flutter Developer Intern',
      company: 'Nextpak Agile Solutions',
      period: 'Feb 2025 – Jul 2025',
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
      period: 'Aug 2025 – May 2026',
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
          constraints: const BoxConstraints(maxWidth: 800),
          child: AnimatedSection(
            child: Column(
              children: [
                _buildSectionLabel('EXPERIENCE'),
                16.height,
                Text(
                  'My Journey',
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
                Container(
                  width: 100,
                  height: 4,
                  decoration: BoxDecoration(
                    gradient: AppColors.accentGradient,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                48.height,
                AnimatedSection(
                  delay: const Duration(milliseconds: 200),
                  child: _Timeline(entries: _entries),
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
}

class _ExperienceEntry {
  final String role;
  final String company;
  final String period;
  final List<String> descriptions;

  const _ExperienceEntry({
    required this.role,
    required this.company,
    required this.period,
    required this.descriptions,
  });
}

class _Timeline extends StatelessWidget {
  final List<_ExperienceEntry> entries;

  const _Timeline({required this.entries});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 11,
          top: 8,
          bottom: 8,
          child: Container(
            width: 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.primaryAccent.withValues(alpha: 0.9),
                  AppColors.secondaryAccent.withValues(alpha: 0.5),
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
              _TimelineRow(entry: entries[i]),
              if (i < entries.length - 1) 32.height,
            ],
          ],
        ),
      ],
    );
  }
}

class _TimelineRow extends StatelessWidget {
  final _ExperienceEntry entry;

  const _TimelineRow({
    required this.entry,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppColors.accentGradient,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryAccent.withValues(alpha: 0.35),
                      blurRadius: 12,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.work_outline_rounded,
                  size: 14,
                  color: AppColors.primaryText,
                ),
              ),
            ],
          ),
          20.width,
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(bottom: 4),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.secondaryBackground,
                  width: 1,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(
                  Responsive.value(
                    context,
                    mobile: 18.0,
                    desktop: 22.0,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.role,
                      style: AppTextStyles.heading4.copyWith(
                        fontSize: Responsive.value(
                          context,
                          mobile: 17.0,
                          desktop: 19.0,
                        ),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    6.height,
                    Text(
                      entry.company,
                      style: AppTextStyles.body1.copyWith(
                        fontSize: 15,
                        color: AppColors.primaryAccent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    10.height,
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 14,
                          color: AppColors.tertiaryText,
                        ),
                        8.width,
                        Text(
                          entry.period,
                          style: AppTextStyles.caption.copyWith(
                            fontSize: 13,
                            color: AppColors.secondaryText,
                          ),
                        ),
                      ],
                    ),
                    16.height,
                    ...entry.descriptions.map((description) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 6),
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.primaryAccent,
                                ),
                              ),
                              12.width,
                              Expanded(
                                child: Text(
                                  description,
                                  style: AppTextStyles.body2.copyWith(
                                    fontSize: 13,
                                    color: AppColors.secondaryText,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
