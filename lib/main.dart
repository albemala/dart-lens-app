import 'package:dart_lens/views/app-view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  GoogleFonts.config.allowRuntimeFetching = false;

  runApp(
    const AppView(),
  );
}
