import 'package:flutter/material.dart';
import '../config/theme.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppTheme.accentColor),
            strokeWidth: 3,
          ),
          SizedBox(height: 16),
          Text(
            'Chargement en cours...',
            style: TextStyle(
              fontFamily: 'SFProText',
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppTheme.textColor,
            ),
          ),
        ],
      ),
    );
  }
}