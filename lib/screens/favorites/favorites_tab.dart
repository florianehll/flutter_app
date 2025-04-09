import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../blocs/favorites/favorites_bloc.dart';
import '../../config/theme.dart';
import '../../widgets/artist_list_item.dart';
import '../../widgets/album_list_item.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/loading_widget.dart';

class FavoritesTab extends StatelessWidget {
  const FavoritesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favoris',
          style: AppTheme.headingStyle,
        ),
      ),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          if (state.status == FavoritesStatus.loading) {
            return const LoadingWidget();
          } else if (state.status == FavoritesStatus.failure) {
            return AppErrorWidget(
              message: state.error ?? 'Erreur lors du chargement des favoris',
              onRetry: () {
                context.read<FavoritesBloc>().add(const LoadFavorites());
              },
            );
          } else if (state.status == FavoritesStatus.success) {
            if (state.artists.isEmpty && state.albums.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/Like_off.svg',
                      width: 64,
                      height: 64,
                      colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Aucun favori pour le moment',
                      style: AppTheme.titleStyle,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Ajoutez des artistes et des albums à vos favoris',
                      style: AppTheme.subtitleStyle,
                    ),
                  ],
                ),
              );
            }
            
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 16, top: 16, bottom: 8),
                    child: Text(
                      'Mes artistes & albums',
                      style: AppTheme.subtitleStyle,
                    ),
                  ),
                  
                  // Artists section
                  if (state.artists.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                          child: Text(
                            'Artistes',
                            style: AppTheme.titleStyle,
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.artists.length,
                          itemBuilder: (context, index) {
                            final artist = state.artists[index];
                            return ArtistListItem(
                              artist: artist,
                              onTap: () {
                                if (artist.id != null) {
                                  context.go('/artist/${artist.id}');
                                }
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  
                  // Albums section
                  if (state.albums.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                          child: Text(
                            'Albums',
                            style: AppTheme.titleStyle,
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.albums.length,
                          itemBuilder: (context, index) {
                            final album = state.albums[index];
                            return AlbumListItem(
                              album: album,
                              onTap: () {
                                if (album.id != null) {
                                  context.go('/album/${album.id}');
                                }
                              },
                            );
                          },
                        ),
                      ],
                    ),
                ],
              ),
            );
          }
          
          return const SizedBox.shrink();
        },
      ),
    );
  }
}