import 'package:flutter/material.dart';
import 'package:portfolio_website/utils/extension.dart';
import '../utils/app_colors.dart';
import '../utils/app_constant.dart';
import '../utils/app_styles.dart';
import '../utils/responsive.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.value(
          context,
          mobile: AppConstants.paddingMedium,
          desktop: AppConstants.paddingXLarge,
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
          child: Column(
            children: [
              // Section title
              Text(
                'Get In Touch',
                style: AppTextStyles.heading2.copyWith(
                  fontSize: Responsive.value(
                    context,
                    mobile: 28.0,
                    desktop: 36.0,
                  ),
                ),
              ),
              AppConstants.paddingMedium.height,

              // Underline
              Container(
                width: 60,
                height: 4,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      AppColors.primaryAccent,
                      AppColors.secondaryAccent
                    ],
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              AppConstants.paddingXLarge.height,

              // Description
              Text(
                'I\'m currently open to new opportunities and collaborations. '
                'Whether you have a question or just want to say hi, feel free to reach out!',
                style: AppTextStyles.body1.copyWith(
                  fontSize: Responsive.value(
                    context,
                    mobile: 14.0,
                    desktop: 16.0,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
              (AppConstants.paddingXLarge + 8).height,

              // Contact links
              Wrap(
                spacing: AppConstants.paddingLarge,
                runSpacing: AppConstants.paddingMedium,
                alignment: WrapAlignment.center,
                children: [
                  _ContactLink(
                    icon: Icons.email_outlined,
                    label: AppConstants.email,
                    onTap: () {
                      // Open email
                    },
                  ),
                  _ContactLink(
                    icon: Icons.code,
                    label: 'GitHub',
                    onTap: () {
                      // https://github.com/HasnainChd
                    },
                  ),
                  _ContactLink(
                    icon: Icons.work_outline,
                    label: 'LinkedIn',
                    onTap: () {},
                  ),
                ],
              ),
              (AppConstants.paddingXLarge + 16).height,

              // Footer
              Container(
                padding: const EdgeInsets.only(top: AppConstants.paddingLarge),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: AppColors.secondaryBackground,
                      width: 1,
                    ),
                  ),
                ),
                child: Text(
                  '© ${DateTime.now().year} ${AppConstants.name}. Built with Flutter 💙',
                  style: AppTextStyles.body2.copyWith(
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactLink extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ContactLink({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  State<_ContactLink> createState() => _ContactLinkState();
}

class _ContactLinkState extends State<_ContactLink> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.value(
              context,
              mobile: 20.0,
              desktop: 24.0,
            ),
            vertical: Responsive.value(
              context,
              mobile: 12.0,
              desktop: 14.0,
            ),
          ),
          decoration: BoxDecoration(
            color: isHovered
                ? AppColors.primaryAccent.withValues(alpha: .1)
                : AppColors.cardBackground,
            borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
            border: Border.all(
              color: isHovered
                  ? AppColors.primaryAccent
                  : AppColors.secondaryBackground,
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: 20,
                color: isHovered
                    ? AppColors.primaryAccent
                    : AppColors.secondaryText,
              ),
              AppConstants.paddingSmall.width,
              Text(
                widget.label,
                style: AppTextStyles.body1.copyWith(
                  fontSize: 15,
                  color: isHovered
                      ? AppColors.primaryAccent
                      : AppColors.primaryText,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
