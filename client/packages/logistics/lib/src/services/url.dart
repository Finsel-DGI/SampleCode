import 'dart:async';

import 'package:logistics/logistics.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlService {
  
    static Future<void> launchURL(String url,
      {bool? browser,
      bool? webViewWithJS,
      bool? webViewWithNoDOM,
      WebViewConfiguration? webViewConfiguration,
      Map<String, String> headers = const <String, String>{},
      Future<void> Function()? performAfter}) async {
    var uri = Uri.parse(url);

    if (browser == true) {
      await launchUrl(
        uri,
        webViewConfiguration:
            webViewConfiguration ?? WebViewConfiguration(headers: headers),
        mode: LaunchMode.externalApplication,
      );
    } else if (webViewWithJS == true) {
      await _launchInWebViewWithoutJavaScript(uri);
    } else if (webViewWithNoDOM == true) {
      await _launchInWebViewWithoutDomStorage(uri);
    } else {
      await _launchInWebViewOrVC(uri);
    }

    if (performAfter != null) {
      unawaited(performAfter());
    }

  }

  static Future<void> _launchInWebViewOrVC(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(
          headers: <String, String>{}),
    )) {
      throw CustomException('Could not launch $url');
    }
  }

  static Future<void> _launchInWebViewWithoutDomStorage(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(enableDomStorage: false),
    )) {
      throw CustomException('Could not launch $url');
    }
  }

  static Future<void> _launchInWebViewWithoutJavaScript(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(enableJavaScript: false),
    )) {
      throw CustomException('Could not launch $url');
    }
  }

}