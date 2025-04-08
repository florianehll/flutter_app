import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../api/models/album.dart';

class AlbumListItem extends StatelessWidget {
  final Album album;
  final VoidCallback? onTap;

  const AlbumListItem({
    Key? key,
    required this.album,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: SizedBox(
        width: 50,
        height: 50,
        child: album.thumbUrl != null
            ? CachedNetworkImage(
                imageUrl: album.thumbUrl!,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey[300],
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.album, size: 25),
                ),
              )
            : Container(
                color: Colors.grey[300],
                child: const Icon(Icons.album, size: 25),
              ),
      ),
      title: Text(
        album.name ?? 'Album inconnu',
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: album.artistName != null
          ? Text(album.artistName!)
          : null,
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}