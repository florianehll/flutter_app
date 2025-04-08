import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../api/models/album.dart';

class AlbumGridItem extends StatelessWidget {
  final Album album;
  final VoidCallback? onTap;

  const AlbumGridItem({
    Key? key,
    required this.album,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Album cover
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: album.thumbUrl != null
                  ? CachedNetworkImage(
                      imageUrl: album.thumbUrl!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      placeholder: (context, url) => Container(
                        color: Colors.grey[300],
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey[300],
                        child: const Icon(Icons.album, size: 40),
                      ),
                    )
                  : Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.album, size: 40),
                    ),
            ),
          ),
          
          // Album name
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              album.name ?? 'Album inconnu',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          
          // Year
          if (album.yearReleased != null)
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Text(
                album.yearReleased!,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ),
        ],
      ),
    );
  }
}