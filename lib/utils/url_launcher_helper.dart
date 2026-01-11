import 'package:url_launcher/url_launcher.dart';

class UrlLauncherHelper {
  // Launch URL in browser
  static Future<void> launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

// Launch email via Gmail web (better for web portfolios)
  static Future<void> launchEmail(String email) async {
    final gmailUrl =
        'https://mail.google.com/mail/?view=cm&fs=1&to=$email&su=Hello!&body=Hi, I found your portfolio...';
    await launchURL(gmailUrl);
  }

  // Launch phone (if you want to add phone number later)
  static Future<void> launchPhone(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);

    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Could not launch phone';
    }
  }

  // Open GitHub profile
  static Future<void> openGitHub(String username) async {
    await launchURL('https://github.com/$username');
  }

  // Open LinkedIn profile
  static Future<void> openLinkedIn(String profile) async {
    await launchURL('https://linkedin.com/in/$profile');
  }
}
