import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remote_collab_tool/theme/pallete.dart';

AppBar createAppBar({title = 'RCT'}) {
  return AppBar(
    backgroundColor: Pallete.bgColor,
    elevation: 0,
    title: Center(
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 25,
          fontWeight: FontWeight.w600,
          color: Pallete.headlineTextColor,
        ),
      ),
    ),
    centerTitle: true,
  );
}
