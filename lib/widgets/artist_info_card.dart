import 'package:flutter/material.dart';
import '../config/theme.dart';

class ArtistInfoCard extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isActive;
  final Color backgroundColor;
  final Color textColor;

  const ArtistInfoCard({
    Key? key,
    required this.label,
    required this.onTap,
    this.isActive = false,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isActive ? AppTheme.accentColor : Colors.grey[300]!,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'SFProText',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}