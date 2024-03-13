import 'package:flutter/material.dart';

class PriorityUtils {
  static String getPriorityLabel(int priority) {
    switch (priority) {
      case 1:
        return 'Low';
      case 2:
        return 'Medium';
      case 3:
        return 'High';
      default:
        return 'Low';
    }
  }

  static Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.grey;
      case 2:
        return Colors.amber;
      case 3:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  static int getPriorityValue(String val) {
    switch (val) {
      case 'high':
        return 3;
      case 'medium':
        return 2;
      case 'low':
        return 1;
      default:
        return 1;
    }
  }
}
