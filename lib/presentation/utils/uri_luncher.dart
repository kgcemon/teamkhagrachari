import 'package:url_launcher/url_launcher.dart';

Future<void> uriLaunchUrl(String data) async {
  if (!await launchUrl(Uri.parse(data))) {
    throw Exception('Could not launch $data');
  }
}