import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
                    child: SvgPicture.asset(
                      'assets/icons/Placeholder_artiste.svg',
                      width: 25,
                      height: 25,
                      colorFilter: ColorFilter.mode(Colors.grey[600]!, BlendMode.srcIn),
                    ),
                  ),
                )
              : Container(
                  color: Colors.grey[300],
                  child: SvgPicture.asset(
                    'assets/icons/Placeholder_artiste.svg',
                    width: 25,
                    height: 25,
                    colorFilter: ColorFilter.mode(Colors.grey[600]!, BlendMode.srcIn),
                  ),
                ),
        ),
      ),
      title: Text(
        artist.name ?? 'Artiste inconnu',
        style: const TextStyle(
          fontFamily: 'SFPro',
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: artist.genre != null
          ? Text(
              artist.genre!,
              style: const TextStyle(
                fontFamily: 'SFPro',
              ),
            )
          : null,
      trailing: SvgPicture.asset(
        'assets/icons/Fleche_droite.svg',
        width: 20,
        height: 20,
        colorFilter: ColorFilter.mode(Colors.grey[600]!, BlendMode.srcIn),
      ),
      onTap: onTap,
    );
  }
}