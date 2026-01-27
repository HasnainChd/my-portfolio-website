import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_styles.dart';
import '../utils/app_constant.dart';
import '../utils/responsive.dart';
import '../utils/resume_helper.dart';

class NavBar extends StatefulWidget {
  final Function(int) onNavItemTapped;
  final int currentIndex;

  const NavBar({
    super.key,
    required this.onNavItemTapped,
    required this.currentIndex,
  });

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final List<String> navItems = [
    'HOME',
    'ABOUT',
    'SKILLS',
    'PROJECTS',
    'CONTACT'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.value(
          context,
          mobile: AppConstants.paddingMedium,
          desktop: AppConstants.paddingXLarge * 2,
        ),
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryBackground.withValues(alpha: 0.8),
        border: Border(
          bottom: BorderSide(
            color: AppColors.secondaryBackground.withValues(alpha: 0.5),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo/Name
          _buildLogo(),

          // Navigation items (Desktop only)
          if (Responsive.isDesktop(context))
            Row(
              children: [
                ...List.generate(navItems.length, (index) {
                  final isActive = widget.currentIndex == index;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: _NavItem(
                      label: navItems[index],
                      isActive: isActive,
                      onTap: () => widget.onNavItemTapped(index),
                    ),
                  );
                }),
                const SizedBox(width: 20),
                _buildResumeButton(),
              ],
            ),

          // Mobile menu
          if (!Responsive.isDesktop(context))
            Row(
              children: [
                _buildResumeButton(),
                const SizedBox(width: 12),
                IconButton(
                  icon: const Icon(
                    Icons.menu_rounded,
                    color: AppColors.primaryText,
                    size: 28,
                  ),
                  onPressed: () => _showMobileDrawer(context),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            gradient: AppColors.accentGradient,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              AppConstants.name.split(' ').map((e) => e[0]).take(2).join(),
              style: AppTextStyles.heading4.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          AppConstants.name.split(' ').first,
          style: AppTextStyles.heading4.copyWith(
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildResumeButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.buttonGradient,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryAccent.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () async {
            try {
              // Show options dialog
              _showResumeOptions(context);
            } catch (e) {
              debugPrint('Error with resume: $e');
            }
          },
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.value(
                context,
                mobile: 16.0,
                desktop: 24.0,
              ),
              vertical: 12,
            ),
            child: Text(
              'RESUME',
              style: AppTextStyles.label.copyWith(
                color: AppColors.primaryText,
                fontWeight: FontWeight.w600,
                fontSize: 14,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showMobileDrawer(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Navigation',
      barrierColor: Colors.black87,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Align(
          alignment: Alignment.centerRight,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            )),
            child: Material(
              color: AppColors.cardBackground,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.75,
                height: double.infinity,
                padding: const EdgeInsets.all(AppConstants.paddingLarge),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Menu', style: AppTextStyles.heading3),
                          IconButton(
                            icon: const Icon(
                              Icons.close_rounded,
                              color: AppColors.primaryText,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      ...List.generate(navItems.length, (index) {
                        final isActive = widget.currentIndex == index;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 24),
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              widget.onNavItemTapped(index);
                            },
                            child: Row(
                              children: [
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  width: isActive ? 4 : 0,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    gradient: AppColors.accentGradient,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                                if (isActive) const SizedBox(width: 12),
                                Text(
                                  navItems[index],
                                  style: AppTextStyles.heading4.copyWith(
                                    color: isActive
                                        ? AppColors.primaryAccent
                                        : AppColors.secondaryText,
                                    fontWeight: isActive
                                        ? FontWeight.w600
                                        : FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                      const Spacer(),
                      Text(
                        '© ${DateTime.now().year} ${AppConstants.name}',
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showResumeOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.all(20),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: AppColors.accentGradient.scale(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.description_outlined,
                color: AppColors.primaryAccent,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Flexible(
              // Make text flexible
              child: Text(
                'Resume',
                style: AppTextStyles.heading3.copyWith(fontSize: 22),
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          // Make content scrollable
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Choose an option:',
                style: AppTextStyles.body1,
              ),
              const SizedBox(height: 20),
              _ResumeOptionButton(
                icon: Icons.download_rounded,
                label: 'Download Resume',
                description: 'Save PDF to your device',
                onTap: () async {
                  Navigator.pop(context);
                  try {
                    await ResumeHelper.downloadResume();
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Resume downloaded successfully!'),
                          backgroundColor: AppColors.primaryAccent,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Failed to download: $e'),
                            backgroundColor: AppColors.redColor),
                      );
                    }
                  }
                },
              ),
              const SizedBox(height: 12),
              _ResumeOptionButton(
                icon: Icons.open_in_new_rounded,
                label: 'View Resume',
                description: 'Open in new tab',
                onTap: () async {
                  Navigator.pop(context);
                  try {
                    await ResumeHelper.openResumeInNewTab();
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Failed to open: $e'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: AppTextStyles.body1.copyWith(
                color: AppColors.secondaryText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: InkWell(
        onTap: widget.onTap,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: AppTextStyles.label.copyWith(
            color: widget.isActive || isHovered
                ? AppColors.primaryText
                : AppColors.secondaryText,
            fontWeight: widget.isActive ? FontWeight.w600 : FontWeight.w500,
            fontSize: 14,
          ),
          child: Text(widget.label),
        ),
      ),
    );
  }
}

class _ResumeOptionButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final String description;
  final VoidCallback onTap;

  const _ResumeOptionButton({
    required this.icon,
    required this.label,
    required this.description,
    required this.onTap,
  });

  @override
  State<_ResumeOptionButton> createState() => _ResumeOptionButtonState();
}

class _ResumeOptionButtonState extends State<_ResumeOptionButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(14), // Reduced from 16
          decoration: BoxDecoration(
            gradient: isHovered ? AppColors.accentGradient.scale(0.15) : null,
            color: isHovered ? null : AppColors.secondaryBackground,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isHovered
                  ? AppColors.primaryAccent
                  : AppColors.secondaryBackground,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min, // Prevent unnecessary stretching
            children: [
              Icon(
                widget.icon,
                color: AppColors.primaryAccent,
                size: 24, // Reduced from 28
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.label,
                      style: AppTextStyles.heading4.copyWith(
                        fontSize: 15, // Reduced from 16
                        color: isHovered
                            ? AppColors.primaryAccent
                            : AppColors.primaryText,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.description,
                      style: AppTextStyles.body2.copyWith(
                        fontSize: 12, // Reduced from 13
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.arrow_forward_rounded,
                color: AppColors.secondaryText,
                size: 18, // Reduced from 20
              ),
            ],
          ),
        ),
      ),
    );
  }
}
