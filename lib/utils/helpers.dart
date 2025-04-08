import 'package:flutter/material.dart';

class Helpers {
  static String formatDuration(String? durationString) {
    if (durationString == null || durationString.isEmpty) {
      return '';
    }
    
    try {
      final duration = int.parse(durationString);
      final minutes = (duration / 60).floor();
      final seconds = duration % 60;
      
      return '$minutes:${seconds.toString().padLeft(2, '0')}';
    } catch (e) {
      return durationString;
    }
  }
  
  static String getLocalizedValue(Map<String, String?> values, BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    
    switch (locale) {
      case 'fr':
        return values['fr'] ?? values['en'] ?? '';
      case 'de':
        return values['de'] ?? values['en'] ?? '';
      case 'es':
        return values['es'] ?? values['en'] ?? '';
      case 'it':
        return values['it'] ?? values['en'] ?? '';
      default:
        return values['en'] ?? '';
    }
  }
  
  static String getValidImageUrl(String? url) {
    if (url == null || url.isEmpty) {
      return '';
    }
    return url.startsWith('http') ? url : 'https://www.theaudiodb.com/images/$url';
  }
}