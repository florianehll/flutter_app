import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
                  child: SvgPicture.asset(
                    'assets/icons/Placeholder_album.svg',
                    width: 25,
                    height: 25,
                    colorFilter: ColorFilter.mode(Colors.grey[600]!, BlendMode.srcIn),
                  ),
                ),
              )
            : Container(
                color: Colors.grey[300],
                child: SvgPicture.asset(
                  'assets/icons/Placeholder_album.svg',
                  width: 25,
                  height: 25,
                  colorFilter: ColorFilter.mode(Colors.grey[600]!, BlendMode.srcIn),
                ),
              ),
      ),
      title: Text(
        album.name ?? 'Album inconnu',
        style: const TextStyle(
          fontFamily: 'SFPro',
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: album.artistName != null
          ? Text(
              album.artistName!,
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