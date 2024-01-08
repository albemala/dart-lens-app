import 'package:dart_lens/app/view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  GoogleFonts.config.allowRuntimeFetching = false;

  runApp(
    const AppView(),
  );
}
