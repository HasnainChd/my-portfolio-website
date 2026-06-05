import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';

class ScrollToTopButton extends StatefulWidget {
  final ScrollController scrollController;

  const ScrollToTopButton({super.key, required this.scrollController});

  @override
  State<ScrollToTopButton> createState() => _ScrollToTopButtonState();
}

class _ScrollToTopButtonState extends State<ScrollToTopButton> {
  bool _visible = false;
  bool _isHovered = false;

  static const double _showThreshold = 400;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    final shouldShow = widget.scrollController.offset >= _showThreshold;
    if (shouldShow != _visible) {
      setState(() => _visible = shouldShow);
    }
  }

  void _scrollToTop() {
    widget.scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 300),
      child: AnimatedSlide(
        offset: _visible ? Offset.zero : const Offset(0, 0.3),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        child: IgnorePointer(
          ignoring: !_visible,
          child: MouseRegion(
            onEnter: (_) => setState(() => _isHovered = true),
            onExit: (_) => setState(() => _isHovered = false),
            child: GestureDetector(
              onTap: _scrollToTop,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                decoration: BoxDecoration(
                  gradient: _isHovered ? AppColors.accentGradient : null,
                  color: _isHovered
                      ? null
                      : (isDark
                          ? AppColors.darkSurface
                          : AppColors.lightSurface),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: _isHovered
                        ? Colors.transparent
                        : AppColors.primaryAccent.withValues(alpha: 0.4),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryAccent
                          .withValues(alpha: _isHovered ? 0.35 : 0.15),
                      blurRadius: _isHovered ? 24 : 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.keyboard_arrow_up_rounded,
                      size: 20,
                      color:
                          _isHovered ? Colors.white : AppColors.primaryAccent,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Top',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color:
                            _isHovered ? Colors.white : AppColors.primaryAccent,
                      ),
                    ),
                  ],
                ),
              ).animate(target: _isHovered ? 1 : 0).scaleXY(
                    begin: 1,
                    end: 1.05,
                    duration: 150.ms,
                    curve: Curves.easeOut,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
