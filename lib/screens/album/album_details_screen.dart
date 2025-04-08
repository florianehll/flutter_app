import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../api/models/album.dart';
import '../../api/models/track.dart';
import '../../blocs/album/album_bloc.dart';
import '../../config/theme.dart';
import '../../utils/helpers.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/loading_widget.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AlbumDetailsScreen extends StatefulWidget {
  final String albumId;

  const AlbumDetailsScreen({Key? key, required this.albumId}) : super(key: key);

  @override
  State<AlbumDetailsScreen> createState() => _AlbumDetailsScreenState();
}

class _AlbumDetailsScreenState extends State<AlbumDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AlbumBloc>().add(LoadAlbumDetails(widget.albumId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AlbumBloc, AlbumState>(
        builder: (context, state) {
          if (state is AlbumLoading) {
            return const LoadingWidget();
          } else if (state is AlbumError) {
            return AppErrorWidget(
              message: state.message,
              onRetry: () {
                context.read<AlbumBloc>().add(LoadAlbumDetails(widget.albumId));
              },
            );
          } else if (state is AlbumLoaded) {
            final album = state.album;
            return CustomScrollView(
              slivers: [
                _buildAppBar(context, album),
                _buildAlbumDetails(context, album, state),
                _buildTracksList(context, state),
              ],
            );
          }
          
          return const SizedBox.shrink();
        },
      ),
    );
  }
  
  Widget _buildAppBar(BuildContext context, Album album) {
    return SliverAppBar(
      expandedHeight: 250,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Album Image
            if (album.thumbUrl != null)
              CachedNetworkImage(
                imageUrl: album.thumbUrl!,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey[300],
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.album, size: 80),
                ),
              )
            else
              Container(
                color: Colors.grey[300],
                child: const Icon(Icons.album, size: 80),
              ),
            
            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
            
            // Album name and artist info
            Positioned(
              left: 16,
              right: 80,
              bottom: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    album.name ?? 'Album',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (album.artistName != null)
                    GestureDetector(
                      onTap: () {
                        if (album.artistId != null) {
                          context.go('/artist/${album.artistId}');
                        }
                      },
                      child: Text(
                        album.artistName!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.favorite_border),
          color: Colors.white,
          onPressed: () {
            // Ajouter aux favoris (fonctionnalité non requise pour ce projet)
          },
        ),
      ],
    );
  }
  
  Widget _buildAlbumDetails(BuildContext context, Album album, AlbumLoaded state) {
    final locale = Localizations.localeOf(context).languageCode;
    final description = album.getLocalizedDescription(locale);
    
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Album info
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Album score
                if (album.score != null && album.scoreVotes != null)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          album.score!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${album.scoreVotes!} votes',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                const SizedBox(width: 16),
                
                // Album year, genre, etc.
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (album.yearReleased != null)
                        Text(
                          '${album.yearReleased!}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      if (album.genre != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            'Genre: ${album.genre!}',
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      if (album.style != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            'Style: ${album.style!}',
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            
            // Description
            if (description.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  const Text(
                    'Description',
                    style: AppTheme.titleStyle,
                  ),
                  const SizedBox(height: 8),
                  Html(
                    data: description,
                    style: {
                      "body": Style(
                        fontSize: FontSize(14),
                        lineHeight: LineHeight(1.5),
                      ),
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildTracksList(BuildContext context, AlbumLoaded state) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
            child: Text(
              'Titres',
              style: AppTheme.titleStyle,
            ),
          ),
          
          state.isLoadingTracks
              ? const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
                )
              : state.tracksError != null
                  ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: AppErrorWidget(
                        message: state.tracksError!,
                        onRetry: () {
                          context.read<AlbumBloc>().add(LoadAlbumTracks(widget.albumId));
                        },
                      ),
                    )
                  : state.tracks.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(child: Text('Aucun titre trouvé')),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.tracks.length,
                          itemBuilder: (context, index) {
                            final track = state.tracks[index];
                            return _buildTrackItem(track, index + 1);
                          },
                        ),
        ],
      ),
    );
  }
  
  Widget _buildTrackItem(Track track, int position) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      leading: Text(
        position.toString(),
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      title: Text(
        track.name ?? 'Track $position',
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: track.duration != null
          ? Text(Helpers.formatDuration(track.duration))
          : null,
      trailing: track.musicVideoUrl != null
          ? IconButton(
              icon: const Icon(Icons.play_circle_outline),
              onPressed: () {
                // Ouvrir le lien de la vidéo (fonctionnalité supplémentaire)
              },
            )
          : null,
    );
  }
}