import 'package:dart_lens/urls/defines.dart';
import 'package:dart_lens/urls/functions.dart';
import 'package:send_support_email/send_support_email.dart';

Future<void> sendFeedback() async {
  final email = await generateSupportEmail(supportEmailUrl);
  await openUrl(email);
}
