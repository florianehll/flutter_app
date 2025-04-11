import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../config/theme.dart';

class ChartItemWidget extends StatelessWidget {
  final int rank;
  final String title;
  final String subtitle;
  final String imageUrl;
  final VoidCallback? onTap;

  const ChartItemWidget({
    Key? key,
    required this.rank,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
        child: Row(
          children: [
            // Rank (numéro)
            SizedBox(
              width: 20,
              child: Text(
                rank.toString(),
                style: const TextStyle(
                  fontFamily: 'SFProText',
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: AppTheme.textColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(width: 12),
            
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: SizedBox(
                width: 48,
                height: 48,
                child: imageUrl.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: Colors.grey[300],
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.grey[300],
                          child: const Icon(Icons.music_note, size: 24, color: Colors.grey),
                        ),
                      )
                    : Container(
                        color: Colors.grey[300],
                        child: const Icon(Icons.music_note, size: 24, color: Colors.grey),
                      ),
              ),
            ),
            
            const SizedBox(width: 12),
            
            // Title and subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'SFProText',
                      fontWeight: FontWeight.w600, // SemiBold
                      fontSize: 15,
                      letterSpacing: -0.2,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontFamily: 'SFProText',
                      color: AppTheme.secondaryTextColor,
                      fontWeight: FontWeight.w400, // Regular
                      fontSize: 13,
                      letterSpacing: -0.1,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            
            // Suppression de l'icône flèche à droite pour correspondre à la maquette
          ],
        ),
      ),
    );
  }
}