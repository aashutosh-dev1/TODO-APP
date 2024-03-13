import 'package:flutter/material.dart';

extension SizedBoxExtensions on num {
  SizedBox get sBH => SizedBox(
        height: toDouble(),
      );
  SizedBox get sBW => SizedBox(
        width: toDouble(),
      );
}
