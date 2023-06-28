import 'package:dart_lens/defines/urls.dart';
import 'package:dart_lens/functions/url.dart';
import 'package:send_support_email/send_support_email.dart';

Future<void> sendFeedback() async {
  final email = await generateSupportEmail(supportEmailUrl);
  await openUrl(email);
}
