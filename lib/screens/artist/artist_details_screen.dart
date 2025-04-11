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
  bool _showFullBiography = false;

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
            Positioned(
              left: 16,
              right: 80,
              bottom: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    artist.name ?? 'Artiste',
                    style: const TextStyle(
                      fontFamily: 'SFProDisplay',
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.5,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (artist.country != null)
                    Text(
                      '${artist.country} • ${artist.genre ?? ""}',
                      style: const TextStyle(
                        fontFamily: 'SFProText',
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        BlocBuilder<FavoritesBloc, FavoritesState>(
          builder: (context, state) {
            final isFavorite = state.isArtistFavorite(artist.id ?? '');
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                icon: SvgPicture.asset(
                  isFavorite ? 'assets/icons/Like_on.svg' : 'assets/icons/Like_on.svg',
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    isFavorite ? Colors.red : AppTheme.accentColor,
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
              ),
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
            if (biography.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Biographie',
                    style: TextStyle(
                      fontFamily: 'SFProText',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.4,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (_showFullBiography)
                    Html(
                      data: biography,
                      style: {
                        "body": Style(
                          fontSize: FontSize(14),
                          lineHeight: LineHeight(1.5),
                          fontFamily: 'SFProText',
                          color: AppTheme.textColor,
                          margin: Margins.zero,
                        ),
                      },
                    )
                  else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Html(
                          data: _getTruncatedBiography(biography),
                          style: {
                            "body": Style(
                              fontSize: FontSize(14),
                              lineHeight: LineHeight(1.5),
                              fontFamily: 'SFProText',
                              color: AppTheme.textColor,
                              margin: Margins.zero,
                            ),
                          },
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _showFullBiography = true;
                            });
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(50, 30),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            alignment: Alignment.centerLeft,
                          ),
                          child: const Text(
                            'Voir plus',
                            style: TextStyle(
                              fontFamily: 'SFProText',
                              color: AppTheme.accentColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
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
  
  String _getTruncatedBiography(String biography) {
    if (biography.length < 300) {
      return biography;
    }
    
    int endIndex = 300;
    while (endIndex < biography.length && endIndex < 350) {
      if (biography[endIndex] == '.' || biography[endIndex] == ' ') {
        break;
      }
      endIndex++;
    }
    
    if (endIndex >= 350) {
      endIndex = 300;
    }
    
    return biography.substring(0, endIndex + 1);
  }
  
  Widget _buildAlbumsList(BuildContext context, ArtistLoaded state) {
    if (state.albums.isEmpty && !state.isLoadingAlbums) {
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
              style: TextStyle(
                fontFamily: 'SFProDisplay',
                fontSize: 20,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.4,
              ),
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
                          child: Center(
                            child: Text(
                              'Aucun album trouvé',
                              style: TextStyle(
                                fontFamily: 'SFProText',
                                fontSize: 16,
                              ),
                            ),
                          ),
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