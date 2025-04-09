import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../api/models/artist.dart';
import '../../blocs/artist/artist_bloc.dart';
import '../../blocs/favorites/favorites_bloc.dart';
import '../../config/theme.dart';
import '../../widgets/album_grid_item.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/loading_widget.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ArtistDetailsScreen extends StatefulWidget {
  final String artistId;

  const ArtistDetailsScreen({Key? key, required this.artistId}) : super(key: key);

  @override
  State<ArtistDetailsScreen> createState() => _ArtistDetailsScreenState();
}

class _ArtistDetailsScreenState extends State<ArtistDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ArtistBloc>().add(LoadArtistDetails(widget.artistId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ArtistBloc, ArtistState>(
        builder: (context, state) {
          if (state is ArtistLoading) {
            return const LoadingWidget();
          } else if (state is ArtistError) {
            return AppErrorWidget(
              message: state.message,
              onRetry: () {
                context.read<ArtistBloc>().add(LoadArtistDetails(widget.artistId));
              },
            );
          } else if (state is ArtistLoaded) {
            final artist = state.artist;
            return CustomScrollView(
              slivers: [
                _buildAppBar(context, artist),
                _buildArtistDetails(context, artist, state),
                _buildAlbumsList(context, state),
              ],
            );
          }
          
          return const SizedBox.shrink();
        },
      ),
    );
  }
  
  Widget _buildAppBar(BuildContext context, Artist artist) {
    return SliverAppBar(
      expandedHeight: 250,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Artist Image
            if (artist.thumbUrl != null)
              CachedNetworkImage(
                imageUrl: artist.thumbUrl!,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey[300],
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[300],
                  child: SvgPicture.asset(
                    'assets/icons/Placeholder_artiste.svg',
                    width: 80,
                    height: 80,
                    colorFilter: ColorFilter.mode(Colors.grey[600]!, BlendMode.srcIn),
                  ),
                ),
              )
            else
              Container(
                color: Colors.grey[300],
                child: SvgPicture.asset(
                  'assets/icons/Placeholder_artiste.svg',
                  width: 80,
                  height: 80,
                  colorFilter: ColorFilter.mode(Colors.grey[600]!, BlendMode.srcIn),
                ),
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
            
            // Artist name
            Positioned(
              left: 16,
              right: 80,
              bottom: 16,
              child: Text(
                artist.name ?? 'Artiste',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SFPro',
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      actions: [
        // Favorite button
        BlocBuilder<FavoritesBloc, FavoritesState>(
          builder: (context, state) {
            final isFavorite = state.isArtistFavorite(artist.id ?? '');
            return IconButton(
              icon: SvgPicture.asset(
                isFavorite ? 'assets/icons/Like_on.svg' : 'assets/icons/Like_off.svg',
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  isFavorite ? Colors.red : Colors.white,
                  BlendMode.srcIn,
                ),
              ),
              onPressed: () {
                if (isFavorite) {
                  context.read<FavoritesBloc>().add(RemoveFavoriteArtist(artist.id ?? ''));
                } else {
                  context.read<FavoritesBloc>().add(AddFavoriteArtist(artist));
                }
              },
            );
          },
        ),
      ],
    );
  }
  
  Widget _buildArtistDetails(BuildContext context, Artist artist, ArtistLoaded state) {
    final locale = Localizations.localeOf(context).languageCode;
    final biography = artist.getLocalizedBiography(locale);
    
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Artist info
            if (artist.genre != null || artist.country != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Row(
                  children: [
                    if (artist.genre != null)
                      Chip(
                        label: Text(artist.genre!),
                        backgroundColor: Colors.grey[200],
                      ),
                    const SizedBox(width: 8),
                    if (artist.country != null)
                      Chip(
                        label: Text(artist.country!),
                        backgroundColor: Colors.grey[200],
                      ),
                  ],
                ),
              ),
            
            // Biography
            if (biography.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Biographie',
                    style: AppTheme.titleStyle,
                  ),
                  const SizedBox(height: 8),
                  Html(
                    data: biography,
                    style: {
                      "body": Style(
                        fontSize: FontSize(14),
                        lineHeight: LineHeight(1.5),
                        fontFamily: 'SFPro',
                      ),
                    },
                  ),
                ],
              ),
              
            // Social links
            if (artist.website != null || artist.facebook != null || artist.twitter != null || artist.instagram != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    'Réseaux sociaux',
                    style: AppTheme.titleStyle,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (artist.website != null)
                        IconButton(
                          icon: SvgPicture.asset(
                            'assets/icons/Etoile.svg', // Utiliser une icône appropriée si disponible
                            width: 24,
                            height: 24,
                            colorFilter: ColorFilter.mode(Colors.grey[800]!, BlendMode.srcIn),
                          ),
                          onPressed: () => _launchUrl(artist.website!),
                        ),
                      if (artist.facebook != null)
                        IconButton(
                          icon: SvgPicture.asset(
                            'assets/icons/Etoile.svg', // Utiliser une icône appropriée si disponible
                            width: 24,
                            height: 24,
                            colorFilter: ColorFilter.mode(Colors.grey[800]!, BlendMode.srcIn),
                          ),
                          onPressed: () => _launchUrl(artist.facebook!),
                        ),
                      if (artist.twitter != null)
                        IconButton(
                          icon: SvgPicture.asset(
                            'assets/icons/Etoile.svg', // Utiliser une icône appropriée si disponible
                            width: 24,
                            height: 24,
                            colorFilter: ColorFilter.mode(Colors.grey[800]!, BlendMode.srcIn),
                          ),
                          onPressed: () => _launchUrl(artist.twitter!),
                        ),
                      if (artist.instagram != null)
                        IconButton(
                          icon: SvgPicture.asset(
                            'assets/icons/Etoile.svg', // Utiliser une icône appropriée si disponible
                            width: 24,
                            height: 24,
                            colorFilter: ColorFilter.mode(Colors.grey[800]!, BlendMode.srcIn),
                          ),
                          onPressed: () => _launchUrl(artist.instagram!),
                        ),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildAlbumsList(BuildContext context, ArtistLoaded state) {
    if (state.albums.isEmpty && !state.isLoadingAlbums) {
      // Load albums if not already loading
      context.read<ArtistBloc>().add(LoadArtistAlbums(widget.artistId));
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }
    
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
            child: Text(
              'Albums',
              style: AppTheme.titleStyle,
            ),
          ),
          
          state.isLoadingAlbums
              ? const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
                )
              : state.albumsError != null
                  ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: AppErrorWidget(
                        message: state.albumsError!,
                        onRetry: () {
                          context.read<ArtistBloc>().add(LoadArtistAlbums(widget.artistId));
                        },
                      ),
                    )
                  : state.albums.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(child: Text('Aucun album trouvé')),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.8,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                            ),
                            itemCount: state.albums.length,
                            itemBuilder: (context, index) {
                              final album = state.albums[index];
                              return AlbumGridItem(
                                album: album,
                                onTap: () {
                                  if (album.id != null) {
                                    context.go('/album/${album.id}');
                                  }
                                },
                              );
                            },
                          ),
                        ),
        ],
      ),
    );
  }
  
  Future<void> _launchUrl(String url) async {
    try {
      final uri = Uri.parse(url.startsWith('http') ? url : 'https://$url');
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Impossible d\'ouvrir ce lien')),
      );
    }
  }
}