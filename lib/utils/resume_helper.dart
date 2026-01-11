import 'package:flutter/services.dart';
import 'package:universal_html/html.dart' as html;

class ResumeHelper {
  static Future<void> downloadResume() async {
    try {
      final ByteData data = await rootBundle.load('assets/resume/myresume.pdf');
      final Uint8List bytes = data.buffer.asUint8List();

      final blob = html.Blob([bytes], 'application/pdf');
      final url = html.Url.createObjectUrlFromBlob(blob);

      final anchor = html.AnchorElement(href: url)
        ..setAttribute('download', 'Muhammad_Hasnain_Resume.pdf')
        ..click();

      html.Url.revokeObjectUrl(url);
    } catch (e) {
      throw 'Failed to download resume: $e';
    }
  }

  static Future<void> openResumeInNewTab() async {
    try {
      // Load the PDF from assets
      final ByteData data = await rootBundle.load('assets/resume/myresume.pdf');
      final Uint8List bytes = data.buffer.asUint8List();

      // Create a blob and open in new tab
      final blob = html.Blob([bytes], 'application/pdf');
      final url = html.Url.createObjectUrlFromBlob(blob);

      // Open in new tab
      html.window.open(url, '_blank');

      // Clean up after a delay
      Future.delayed(const Duration(seconds: 2), () {
        html.Url.revokeObjectUrl(url);
      });
    } catch (e) {
      throw 'Failed to open resume: $e';
    }
  }
}
