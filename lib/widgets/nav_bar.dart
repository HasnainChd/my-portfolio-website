import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';
import '../utils/app_constant.dart';
import '../utils/responsive.dart';
import '../utils/resume_helper.dart';
import '../core/theme/theme_provider.dart';

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
    'Experience',
    'Skills',
    'Services',
    'Achievements',
    'Projects',
    'Contact',
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          height: 80,
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.value(
              context,
              mobile: AppConstants.paddingMedium,
              desktop: AppConstants.paddingXLarge * 2,
            ),
          ),
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.darkBackground.withValues(alpha: 0.75)
                : AppColors.lightBackground.withValues(alpha: 0.85),
            border: Border(
              bottom: BorderSide(
                color: isDark
                    ? AppColors.darkBorder.withValues(alpha: 0.6)
                    : AppColors.lightBorder.withValues(alpha: 0.8),
                width: 1,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildLogo(isDark),

              // WITH:
              if (Responsive.isDesktop(context))
                Flexible(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ...List.generate(navItems.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: _NavItem(
                            label: navItems[index],
                            isActive: widget.currentIndex == index,
                            onTap: () => widget.onNavItemTapped(index),
                          ),
                        );
                      }),
                      const SizedBox(width: 12),
                      _buildThemeToggle(themeProvider, isDark),
                      const SizedBox(width: 8),
                      _buildResumeButton(context, isDark),
                    ],
                  ),
                ),

              // Mobile row
              if (!Responsive.isDesktop(context))
                Row(
                  children: [
                    _buildThemeToggle(themeProvider, isDark),
                    const SizedBox(width: 12),
                    _buildResumeButton(context, isDark),
                    const SizedBox(width: 12),
                    IconButton(
                      icon: Icon(
                        Icons.menu_rounded,
                        color: isDark
                            ? AppColors.darkForeground
                            : AppColors.lightForeground,
                        size: 28,
                      ),
                      onPressed: () => _showMobileDrawer(context, isDark),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(bool isDark) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            gradient: AppColors.accentGradient,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              'MH',
              style: GoogleFonts.outfit(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          'Hasnain',
          style: GoogleFonts.outfit(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color:
                isDark ? AppColors.darkForeground : AppColors.lightForeground,
          ),
        ),
      ],
    );
  }

  Widget _buildThemeToggle(ThemeProvider themeProvider, bool isDark) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          width: 1,
        ),
      ),
      child: IconButton(
        // Show sun when dark (will switch to light), moon when light (will switch to dark)
        icon: Icon(
          isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
          color: AppColors.primaryAccent,
          size: 20,
        ),
        onPressed: () => themeProvider.toggleTheme(),
        padding: EdgeInsets.zero,
      ),
    );
  }

  Widget _buildResumeButton(BuildContext context, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.buttonGradient,
        borderRadius: BorderRadius.circular(999),
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
          onTap: () => _showResumeOptions(context, isDark),
          borderRadius: BorderRadius.circular(999),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.value(
                context,
                mobile: 14.0,
                desktop: 18.0,
              ),
              vertical: 10,
            ),
            child: Text(
              'Resume',
              style: GoogleFonts.plusJakartaSans(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showMobileDrawer(BuildContext context, bool isDark) {
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
              color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
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
                          Text(
                            'Menu',
                            style: GoogleFonts.outfit(
                              fontSize: 28,
                              fontWeight: FontWeight.w600,
                              color: isDark
                                  ? AppColors.darkForeground
                                  : AppColors.lightForeground,
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.close_rounded,
                              color: isDark
                                  ? AppColors.darkForeground
                                  : AppColors.lightForeground,
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
                                  style: GoogleFonts.outfit(
                                    fontSize: 20,
                                    fontWeight: isActive
                                        ? FontWeight.w600
                                        : FontWeight.normal,
                                    color: isActive
                                        ? AppColors.primaryAccent
                                        : (isDark
                                            ? AppColors.darkMutedText
                                            : AppColors.lightMutedText),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                      const Spacer(),
                      Text(
                        '© ${DateTime.now().year} Muhammad Hasnain',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          color: isDark
                              ? AppColors.darkMutedText
                              : AppColors.lightMutedText,
                        ),
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

  void _showResumeOptions(BuildContext context, bool isDark) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor:
            isDark ? AppColors.darkSurface : AppColors.lightSurface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.all(20),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primaryAccent.withValues(alpha: 0.12),
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
              child: Text(
                'Resume',
                style: GoogleFonts.outfit(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: isDark
                      ? AppColors.darkForeground
                      : AppColors.lightForeground,
                ),
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Choose an option:',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  color: isDark
                      ? AppColors.darkMutedText
                      : AppColors.lightMutedText,
                ),
              ),
              const SizedBox(height: 20),
              _ResumeOptionButton(
                icon: Icons.download_rounded,
                label: 'Download Resume',
                description: 'Save PDF to your device',
                isDark: isDark,
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
                          backgroundColor: Colors.red,
                        ),
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
                isDark: isDark,
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
              style: GoogleFonts.plusJakartaSans(
                color:
                    isDark ? AppColors.darkMutedText : AppColors.lightMutedText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Nav Item ────────────────────────────────────────────────────────────────

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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: InkWell(
        onTap: widget.onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: GoogleFonts.plusJakartaSans(
                color: widget.isActive || isHovered
                    ? AppColors.primaryAccent
                    : (isDark
                        ? AppColors.darkMutedText
                        : AppColors.lightMutedText),
                fontWeight: widget.isActive ? FontWeight.w600 : FontWeight.w500,
                fontSize: 14,
                letterSpacing: 0.5,
              ),
              child: Text(widget.label),
            ),
            if (widget.isActive)
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(top: 4),
                width: 4,
                height: 4,
                decoration: const BoxDecoration(
                  color: AppColors.primaryAccent,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ─── Resume Option Button ─────────────────────────────────────────────────────

class _ResumeOptionButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final String description;
  final bool isDark;
  final VoidCallback onTap;

  const _ResumeOptionButton({
    required this.icon,
    required this.label,
    required this.description,
    required this.isDark,
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
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: isHovered
                ? AppColors.primaryAccent.withValues(alpha: 0.08)
                : (widget.isDark
                    ? AppColors.darkSurface
                    : AppColors.lightSurface),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isHovered
                  ? AppColors.primaryAccent.withValues(alpha: 0.5)
                  : (widget.isDark
                      ? AppColors.darkBorder
                      : AppColors.lightBorder),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, color: AppColors.primaryAccent, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.label,
                      style: GoogleFonts.outfit(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: isHovered
                            ? AppColors.primaryAccent
                            : (widget.isDark
                                ? AppColors.darkForeground
                                : AppColors.lightForeground),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.description,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        color: widget.isDark
                            ? AppColors.darkMutedText
                            : AppColors.lightMutedText,
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
                color: widget.isDark
                    ? AppColors.darkMutedText
                    : AppColors.lightMutedText,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
