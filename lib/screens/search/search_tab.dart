import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../blocs/search/search_bloc.dart';
import '../../config/theme.dart';
import '../../widgets/artist_list_item.dart';
import '../../widgets/album_list_item.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/loading_widget.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({Key? key}) : super(key: key);

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final TextEditingController _searchController = TextEditingController();
  
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Rechercher',
          style: AppTheme.headingStyle,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Rechercher un artiste ou un album',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          context.read<SearchBloc>().add(const ClearSearch());
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              onChanged: (query) {
                context.read<SearchBloc>().add(SearchQueryChanged(query));
              },
            ),
          ),
          
          // Results
          Expanded(
            child: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state is SearchInitial) {
                  return const Center(
                    child: Text('Recherchez des artistes ou des albums'),
                  );
                } else if (state is SearchLoading) {
                  return const LoadingWidget();
                } else if (state is SearchResults) {
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Artists section
                        if (state.artistsStatus == SearchStatus.loading)
                          const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Center(child: CircularProgressIndicator()),
                          )
                        else if (state.artistsStatus == SearchStatus.failure)
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: AppErrorWidget(
                              message: state.artistsError ?? 'Erreur lors de la recherche d\'artistes',
                              onRetry: () {
                                context.read<SearchBloc>().add(SearchArtists(state.query));
                              },
                            ),
                          )
                        else if (state.artistsStatus == SearchStatus.success && state.artists.isNotEmpty)
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
                        if (state.albumsStatus == SearchStatus.loading)
                          const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Center(child: CircularProgressIndicator()),
                          )
                        else if (state.albumsStatus == SearchStatus.failure)
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: AppErrorWidget(
                              message: state.albumsError ?? 'Erreur lors de la recherche d\'albums',
                              onRetry: () {
                                context.read<SearchBloc>().add(SearchAlbums(state.query));
                              },
                            ),
                          )
                        else if (state.albumsStatus == SearchStatus.success && state.albums.isNotEmpty)
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
          ),
        ],
      ),
    );
  }
}