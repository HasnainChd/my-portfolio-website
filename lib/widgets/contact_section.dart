import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portfolio_website/utils/extension.dart';
import 'package:portfolio_website/widgets/animated_section.dart';
import '../services/contact_service.dart';
import '../utils/app_colors.dart';
import '../utils/app_constant.dart';
import '../utils/app_styles.dart';
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
    if (!_formKey.currentState!.validate()) {
      return;
    }

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
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

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
          constraints: const BoxConstraints(maxWidth: 900),
          child: AnimatedSection(
            child: Column(
              children: [
                // Section label
                _buildSectionLabel('GET IN TOUCH'),
                16.height,

                // Section title
                Text(
                  'Let\'s Work Together',
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

                // Decorative line
                Container(
                  width: 100,
                  height: 4,
                  decoration: BoxDecoration(
                    gradient: AppColors.accentGradient,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                24.height,

                // Description
                Text(
                  'I\'m currently open to new opportunities and collaborations. '
                  'Whether you have a question or just want to say hi, feel free to reach out!',
                  style: AppTextStyles.body1.copyWith(
                    fontSize: Responsive.value(
                      context,
                      mobile: 16.0,
                      desktop: 18.0,
                    ),
                    color: AppColors.secondaryText,
                  ),
                  textAlign: TextAlign.center,
                ),
                48.height,

                // Contact links
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
                        onTap: () async {
                          try {
                            await UrlLauncherHelper.launchEmail(
                                AppConstants.email);
                          } catch (e) {
                            if (context.mounted) {
                              _showEmailOptions(context);
                            }
                          }
                        },
                      ),
                      _ContactLink(
                        icon: Icons.code_rounded,
                        label: 'GitHub',
                        value: '@${AppConstants.githubUsername}',
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

                // Contact Form
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
                      color: AppColors.cardBackground,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.secondaryBackground,
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
                            style: AppTextStyles.heading3.copyWith(
                              fontSize: 20,
                            ),
                          ),
                          24.height,
                          _buildTextField(
                            controller: _nameController,
                            label: 'Name',
                            hint: 'Your name',
                            icon: Icons.person_outline,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),
                          16.height,
                          _buildTextField(
                            controller: _emailController,
                            label: 'Email',
                            hint: 'your.email@example.com',
                            icon: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!value.contains('@')) {
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
                            maxLines: 5,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter your message';
                              }
                              if (value.trim().length < 10) {
                                return 'Message must be at least 10 characters';
                              }
                              return null;
                            },
                          ),
                          24.height,
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: _isSubmitting ? null : _submitForm,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryAccent,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
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
                                          Colors.white,
                                        ),
                                      ),
                                    )
                                  : const Text(
                                      'Send Message',
                                      style: TextStyle(
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
                48.height,

                // Footer
                Container(
                  padding: const EdgeInsets.only(
                    top: AppConstants.paddingXLarge,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: AppColors.secondaryBackground,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '© ${DateTime.now().year} ${AppConstants.name}. All rights reserved.',
                        style: AppTextStyles.body2.copyWith(
                          fontSize: 15,
                          color: AppColors.tertiaryText,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      12.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Built with',
                            style: AppTextStyles.body2.copyWith(
                              fontSize: 14,
                              color: AppColors.tertiaryText,
                            ),
                          ),
                          const SizedBox(width: 6),
                          ShaderMask(
                            shaderCallback: (bounds) =>
                                AppColors.accentGradient.createShader(bounds),
                            child: const Text(
                              'Flutter',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Text('💙', style: TextStyle(fontSize: 16)),
                        ],
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

  void _showEmailOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          'Contact via Email',
          style: AppTextStyles.heading3,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'You can reach me at:',
              style: AppTextStyles.body1,
            ),
            AppConstants.paddingMedium.height,
            Container(
              padding: const EdgeInsets.all(AppConstants.paddingMedium),
              decoration: BoxDecoration(
                color: AppColors.secondaryBackground,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: AppColors.primaryAccent.withValues(alpha: .3)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      AppConstants.email,
                      style: AppTextStyles.body1.copyWith(
                        color: AppColors.primaryAccent,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy_rounded,
                        color: AppColors.primaryAccent),
                    tooltip: 'Copy email',
                    onPressed: () {
                      _copyToClipboard(context, AppConstants.email);
                    },
                  ),
                ],
              ),
            ),
            AppConstants.paddingMedium.height,
            Text(
              'Or open in:',
              style: AppTextStyles.body2,
            ),
            AppConstants.paddingSmall.height,
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
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Close',
              style: AppTextStyles.body1.copyWith(
                color: AppColors.primaryAccent,
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
      SnackBar(
        content: const Text('Email copied to clipboard!'),
        backgroundColor: AppColors.primaryAccent,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.body2.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryText,
          ),
        ),
        8.height,
        maxLines > 1
            ? Container(
                decoration: BoxDecoration(
                  color: AppColors.secondaryBackground,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16, right: 12, top: 16),
                      child: Icon(
                        icon,
                        color: AppColors.primaryAccent,
                        size: 20,
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: controller,
                        maxLines: maxLines,
                        keyboardType: keyboardType,
                        validator: validator,
                        textAlignVertical: TextAlignVertical.top,
                        style: AppTextStyles.body1.copyWith(
                          color: AppColors.primaryText,
                        ),
                        decoration: InputDecoration(
                          hintText: hint,
                          hintStyle: AppTextStyles.body2.copyWith(
                            color: AppColors.tertiaryText,
                          ),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          contentPadding: const EdgeInsets.only(
                            right: 16,
                            top: 16,
                            bottom: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : TextFormField(
                controller: controller,
                maxLines: maxLines,
                keyboardType: keyboardType,
                validator: validator,
                textAlignVertical: TextAlignVertical.center,
                style: AppTextStyles.body1.copyWith(
                  color: AppColors.primaryText,
                ),
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: AppTextStyles.body2.copyWith(
                    color: AppColors.tertiaryText,
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 12),
                    child: Icon(
                      icon,
                      color: AppColors.primaryAccent,
                      size: 20,
                    ),
                  ),
                  prefixIconConstraints: const BoxConstraints(
                    minWidth: 48,
                    minHeight: 48,
                  ),
                  isDense: true,
                  filled: true,
                  fillColor: AppColors.secondaryBackground,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: AppColors.primaryAccent,
                      width: 2,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 1,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 2,
                    ),
                  ),
                  contentPadding: const EdgeInsets.only(
                    left: 0,
                    right: 16,
                    top: 12,
                    bottom: 12,
                  ),
                ),
              ),
      ],
    );
  }
}

class _EmailServiceButton extends StatelessWidget {
  final String label;
  final String url;

  const _EmailServiceButton({
    required this.label,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        try {
          await UrlLauncherHelper.launchURL(url);
          if (context.mounted) {
            Navigator.pop(context);
          }
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
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          gradient: AppColors.accentGradient.scale(0.15),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.primaryAccent),
        ),
        child: Text(
          label,
          style: AppTextStyles.body2.copyWith(
            color: AppColors.primaryAccent,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _ContactLink extends StatefulWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;

  const _ContactLink({
    required this.icon,
    required this.label,
    required this.value,
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
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: Responsive.value(
            context,
            mobile: double.infinity,
            tablet: 280.0,
            desktop: 280.0,
          ),
          padding: EdgeInsets.all(
            Responsive.value(
              context,
              mobile: 20.0,
              desktop: 24.0,
            ),
          ),
          decoration: BoxDecoration(
            gradient: isHovered ? AppColors.accentGradient.scale(0.15) : null,
            color: isHovered ? null : AppColors.cardBackground,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isHovered
                  ? AppColors.primaryAccent
                  : AppColors.secondaryBackground,
              width: isHovered ? 2 : 1,
            ),
            boxShadow: isHovered
                ? [
                    BoxShadow(
                      color: AppColors.primaryAccent.withValues(alpha: 0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : null,
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
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
                widget.label,
                style: AppTextStyles.heading4.copyWith(
                  fontSize: 18,
                  color: isHovered
                      ? AppColors.primaryAccent
                      : AppColors.primaryText,
                ),
              ),
              8.height,
              Text(
                widget.value,
                style: AppTextStyles.body2.copyWith(
                  fontSize: 14,
                  color: AppColors.secondaryText,
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
