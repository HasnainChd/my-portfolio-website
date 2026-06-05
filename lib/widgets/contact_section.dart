import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_website/utils/extension.dart';
import 'package:portfolio_website/widgets/animated_section.dart';
import '../services/contact_service.dart';
import '../utils/app_colors.dart';
import '../utils/app_constant.dart';
import '../utils/responsive.dart';
import '../utils/url_launcher_helper.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    try {
      await ContactService.sendEmail(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        message: _messageController.text.trim(),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Message sent successfully!'),
            backgroundColor: AppColors.primaryAccent,
            behavior: SnackBarBehavior.floating,
          ),
        );
        _formKey.currentState!.reset();
        _nameController.clear();
        _emailController.clear();
        _messageController.clear();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to send message: $e'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

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
          constraints: const BoxConstraints(maxWidth: 900),
          child: AnimatedSection(
            child: Column(
              children: [
                // Section label
                _buildSectionLabel(context, 'GET IN TOUCH'),
                16.height,

                // Heading
                Text(
                  "Let's Work Together",
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

                // Decorative gradient bar
                Container(
                  width: 100,
                  height: 4,
                  decoration: BoxDecoration(
                    gradient: AppColors.accentGradient,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                24.height,

                // Sub-description
                Text(
                  "I'm currently open to new opportunities and collaborations. "
                  'Whether you have a question or just want to say hi, feel free to reach out!',
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
                48.height,

                // Contact link cards
                AnimatedSection(
                  delay: const Duration(milliseconds: 200),
                  child: Wrap(
                    spacing: Responsive.value(
                      context,
                      mobile: 16.0,
                      desktop: 24.0,
                    ),
                    runSpacing: 16,
                    alignment: WrapAlignment.center,
                    children: [
                      _ContactLink(
                        icon: Icons.email_outlined,
                        label: 'Email',
                        value: AppConstants.email,
                        isDark: isDark,
                        onTap: () async {
                          try {
                            await UrlLauncherHelper.launchEmail(
                                AppConstants.email);
                          } catch (_) {
                            if (context.mounted) {
                              _showEmailOptions(context, isDark);
                            }
                          }
                        },
                      ),
                      _ContactLink(
                        icon: Icons.code_rounded,
                        label: 'GitHub',
                        value: '@${AppConstants.githubUsername}',
                        isDark: isDark,
                        onTap: () async {
                          try {
                            await UrlLauncherHelper.openGitHub(
                                AppConstants.githubUsername);
                          } catch (e) {
                            debugPrint('Error launching GitHub: $e');
                          }
                        },
                      ),
                      _ContactLink(
                        icon: Icons.work_outline_rounded,
                        label: 'LinkedIn',
                        value: AppConstants.linkedinProfile,
                        isDark: isDark,
                        onTap: () async {
                          try {
                            await UrlLauncherHelper.openLinkedIn(
                                AppConstants.linkedinProfile);
                          } catch (e) {
                            debugPrint('Error launching LinkedIn: $e');
                          }
                        },
                      ),
                    ],
                  ),
                ),
                48.height,

                // Contact form
                AnimatedSection(
                  delay: const Duration(milliseconds: 300),
                  child: Container(
                    padding: EdgeInsets.all(
                      Responsive.value(
                        context,
                        mobile: 24.0,
                        desktop: 32.0,
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppColors.darkSurface
                          : AppColors.lightSurface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isDark
                            ? AppColors.darkBorder
                            : AppColors.lightBorder,
                        width: 1,
                      ),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Send me a message',
                            style: GoogleFonts.outfit(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: isDark
                                  ? AppColors.darkForeground
                                  : AppColors.lightForeground,
                            ),
                          ),
                          24.height,
                          _buildTextField(
                            controller: _nameController,
                            label: 'Name',
                            hint: 'Your name',
                            icon: Icons.person_outline,
                            isDark: isDark,
                            validator: (v) => (v == null || v.trim().isEmpty)
                                ? 'Please enter your name'
                                : null,
                          ),
                          16.height,
                          _buildTextField(
                            controller: _emailController,
                            label: 'Email',
                            hint: 'your.email@example.com',
                            icon: Icons.email_outlined,
                            isDark: isDark,
                            keyboardType: TextInputType.emailAddress,
                            validator: (v) {
                              if (v == null || v.trim().isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!v.contains('@')) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                          16.height,
                          _buildTextField(
                            controller: _messageController,
                            label: 'Message',
                            hint: 'Your message...',
                            icon: Icons.message_outlined,
                            isDark: isDark,
                            maxLines: 5,
                            validator: (v) {
                              if (v == null || v.trim().isEmpty) {
                                return 'Please enter your message';
                              }
                              if (v.trim().length < 10) {
                                return 'Message must be at least 10 characters';
                              }
                              return null;
                            },
                          ),
                          24.height,
                          SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: ElevatedButton(
                              onPressed: _isSubmitting ? null : _submitForm,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryAccent,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                elevation: 0,
                              ),
                              child: _isSubmitting
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                      ),
                                    )
                                  : Text(
                                      'Send Message',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
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

  void _showEmailOptions(BuildContext context, bool isDark) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor:
            isDark ? AppColors.darkSurface : AppColors.lightSurface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Contact via Email',
          style: GoogleFonts.outfit(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color:
                isDark ? AppColors.darkForeground : AppColors.lightForeground,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'You can reach me at:',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                color:
                    isDark ? AppColors.darkMutedText : AppColors.lightMutedText,
              ),
            ),
            16.height,
            Container(
              padding: const EdgeInsets.all(AppConstants.paddingMedium),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: AppColors.primaryAccent.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      AppConstants.email,
                      style: GoogleFonts.plusJakartaSans(
                        color: AppColors.primaryAccent,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy_rounded,
                        color: AppColors.primaryAccent),
                    tooltip: 'Copy email',
                    onPressed: () =>
                        _copyToClipboard(context, AppConstants.email),
                  ),
                ],
              ),
            ),
            12.height,
            Text(
              'Or open in:',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                color:
                    isDark ? AppColors.darkMutedText : AppColors.lightMutedText,
              ),
            ),
            8.height,
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _EmailServiceButton(
                  label: 'Gmail',
                  url:
                      'https://mail.google.com/mail/?view=cm&fs=1&to=${AppConstants.email}',
                ),
                _EmailServiceButton(
                  label: 'Outlook',
                  url:
                      'https://outlook.office.com/mail/deeplink/compose?to=${AppConstants.email}',
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Close',
              style: GoogleFonts.plusJakartaSans(
                color: AppColors.primaryAccent,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Email copied to clipboard!'),
        backgroundColor: AppColors.primaryAccent,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required bool isDark,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    final iconColor =
        isDark ? AppColors.darkMutedText : AppColors.lightMutedText;
    final fgColor =
        isDark ? AppColors.darkForeground : AppColors.lightForeground;
    final bgColor =
        isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: fgColor,
          ),
        ),
        8.height,
        Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: borderColor, width: 1),
              ),
              child: TextFormField(
                controller: controller,
                maxLines: maxLines,
                keyboardType: keyboardType,
                validator: validator,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  color: fgColor,
                ),
                decoration: InputDecoration(
                  hintText: hint,
                  // Icon handled via Stack — no prefixIcon here
                  prefixIcon: maxLines == 1
                      ? Icon(icon, color: iconColor, size: 20)
                      : null,
                  hintStyle: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    color: iconColor,
                  ),
                  border: InputBorder.none,
                  contentPadding: maxLines > 1
                      ? const EdgeInsets.only(
                          left: 52, top: 16, right: 16, bottom: 16)
                      : const EdgeInsets.all(16),
                ),
              ),
            ),
            // For multiline fields, pin icon manually to top-left
            if (maxLines > 1)
              Positioned(
                left: 14,
                top: 16,
                child: Icon(icon, color: iconColor, size: 20),
              ),
          ],
        ),
      ],
    );
  }
}

// ─── Email service button ─────────────────────────────────────────────────────

class _EmailServiceButton extends StatelessWidget {
  final String label;
  final String url;

  const _EmailServiceButton({required this.label, required this.url});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        try {
          await UrlLauncherHelper.launchURL(url);
          if (context.mounted) Navigator.pop(context);
        } catch (e) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Could not open $label'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.primaryAccent.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: AppColors.primaryAccent),
        ),
        child: Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            color: AppColors.primaryAccent,
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

// ─── Contact link card ────────────────────────────────────────────────────────

class _ContactLink extends StatefulWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;
  final bool isDark;

  const _ContactLink({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
    required this.isDark,
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
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: Responsive.value(
            context,
            mobile: double.infinity,
            tablet: 280.0,
            desktop: 280.0,
          ),
          padding: EdgeInsets.all(
            Responsive.value(context, mobile: 20.0, desktop: 24.0),
          ),
          decoration: BoxDecoration(
            color:
                widget.isDark ? AppColors.darkSurface : AppColors.lightSurface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isHovered
                  ? AppColors.primaryAccent
                  : (widget.isDark
                      ? AppColors.darkBorder
                      : AppColors.lightBorder),
              width: isHovered ? 2 : 1,
            ),
            boxShadow: isHovered
                ? [
                    BoxShadow(
                      color: AppColors.primaryAccent.withValues(alpha: 0.18),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : [],
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.primaryAccent.withValues(alpha: 0.1),
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
                widget.label,
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: isHovered
                      ? AppColors.primaryAccent
                      : (widget.isDark
                          ? AppColors.darkForeground
                          : AppColors.lightForeground),
                ),
              ),
              8.height,
              Text(
                widget.value,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  color: widget.isDark
                      ? AppColors.darkMutedText
                      : AppColors.lightMutedText,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
