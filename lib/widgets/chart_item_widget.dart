import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Rank
          SizedBox(
            width: 24,
            child: Text(
              rank.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 16),
          
          // Image
          SizedBox(
            width: 50,
            height: 50,
            child: imageUrl.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: Colors.grey[300],
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.music_note, size: 25),
                    ),
                  )
                : Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.music_note, size: 25),
                  ),
          ),
        ],
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(subtitle),
      onTap: onTap,
    );
  }
}