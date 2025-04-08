import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../api/models/artist.dart';

class ArtistListItem extends StatelessWidget {
  final Artist artist;
  final VoidCallback? onTap;

  const ArtistListItem({
    Key? key,
    required this.artist,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: SizedBox(
          width: 50,
          height: 50,
          child: artist.thumbUrl != null
              ? CachedNetworkImage(
                  imageUrl: artist.thumbUrl!,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Colors.grey[300],
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.person, size: 25),
                  ),
                )
              : Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.person, size: 25),
                ),
        ),
      ),
      title: Text(
        artist.name ?? 'Artiste inconnu',
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: artist.genre != null
          ? Text(artist.genre!)
          : null,
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}