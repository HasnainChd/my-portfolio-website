import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_constant.dart';
import '../utils/app_styles.dart';

import '../utils/responsive.dart';

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
    'Home',
    'About',
    'Skills',
    'Projects',
    'Contact'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.value(
          context,
          mobile: AppConstants.paddingMedium,
          desktop: AppConstants.paddingXLarge,
        ),
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryBackground.withOpacity(0.95),
        border: const Border(
          bottom: BorderSide(
            color: AppColors.secondaryBackground,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo/Name
          Text(
            AppConstants.name.split(' ').last,
            style: AppTextStyles.heading3.copyWith(
              fontSize: Responsive.value(
                context,
                mobile: 20.0,
                desktop: 24.0,
              ),
            ),
          ),

          // Navigation items (Desktop)
          if (Responsive.isDesktop(context))
            Row(
              children: List.generate(navItems.length, (index) {
                final isActive = widget.currentIndex == index;
                return Padding(
                  padding: const EdgeInsets.only(left: 32),
                  child: _NavItem(
                    label: navItems[index],
                    isActive: isActive,
                    onTap: () => widget.onNavItemTapped(index),
                  ),
                );
              }),
            ),

          // Mobile menu button
          if (!Responsive.isDesktop(context))
            IconButton(
              icon: const Icon(Icons.menu,
                  color: AppColors.primaryText, size: 28),
              onPressed: () {
                _showMobileDrawer(context);
              },
            ),
        ],
      ),
    );
  }

  void _showMobileDrawer(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Navigation',
      barrierColor: Colors.black54,
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
                      // Close button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Menu',
                            style:
                                AppTextStyles.heading3.copyWith(fontSize: 24),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close,
                                color: AppColors.primaryText),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),

                      // Navigation items
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
                                // Indicator
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  width: isActive ? 4 : 0,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        AppColors.primaryAccent,
                                        AppColors.secondaryAccent,
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                                if (isActive) const SizedBox(width: 12),
                                // Label
                                Text(
                                  navItems[index],
                                  style: AppTextStyles.heading3.copyWith(
                                    fontSize: 20,
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

                      // Footer
                      Text(
                        '© ${DateTime.now().year} ${AppConstants.name}',
                        style: AppTextStyles.body2,
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.label,
              style: AppTextStyles.body1.copyWith(
                color: widget.isActive || isHovered
                    ? AppColors.primaryAccent
                    : AppColors.secondaryText,
                fontWeight:
                    widget.isActive ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
            const SizedBox(height: 4),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 2,
              width: widget.isActive ? 30 : 0,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primaryAccent, AppColors.secondaryAccent],
                ),
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
