import 'package:url_launcher/url_launcher.dart';

launchUrls(String myurl) async {
  var myurls = Uri.parse(myurl);
  if (await launchUrl(myurls)) {
    throw Exception('Could not launch $myurls');
  }
}